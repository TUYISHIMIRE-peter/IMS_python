from datetime import timedelta
from flask import Flask, render_template, request, redirect, url_for, session, flash
from flask_mysqldb import MySQL
import MySQLdb.cursors,os
from werkzeug.security import generate_password_hash,check_password_hash

UPLOAD_FOLDER = 'static/uploads/'

app = Flask(__name__)

app.secret_key = 'shardaq'
app.config['PERMANENT_SESSION_LIFETIME']= timedelta(minutes=30)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
# database connection details below
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'ims'

# Intialize MySQL
mysql = MySQL(app)
#------------------------------------------------------------------------------------
@app.route('/', methods=['GET','POST'])
def login():
    msg = ''
    if request.method == 'POST' and 'username' in request.form and 'password' in request.form:
        username = request.form['username']
        password = request.form['password']        
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM `users` WHERE email = %s', [username])
        account = cursor.fetchone()
        passd = account['password']
        if check_password_hash(passd,password):
            # Create session data
            session['loggedin'] = True
            session['id'] = account['id']
            session['username'] = account['last_name']
            session['email'] = account['email']            
            session['user'] = account['first_name']
            session['position'] = account['job_position']
            return redirect(url_for('home'))
        else:
            msg = 'Incorrect username/password!'
    return render_template('/index.html', msg=msg)
#------------------------------------------------------------------------------------
@app.route('/logout')
def logout():
    session.pop('loggedin', None)
    session.pop('id', None)
    session.pop('username', None)
    session.pop('user', None)
    return redirect(url_for('login'))
#------------------------------------------------------------------------------------
@app.route('/profile')
def profile():
    if session['position']=='Admin':
        id = session['id']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("SELECT * FROM `users` WHERE `id`=%s", (id,))
        info = cursor.fetchall()
        return render_template('/Admin/users-profile.html',username=session['username'], user=session['user'], information=info)
    else:
        id = session['id']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("SELECT * FROM `users` WHERE `id`=%s", (id,))
        info = cursor.fetchall()
        return render_template('/users-profile.html',username=session['username'], user=session['user'], information=info)   
#------------------------------------------------------------------------------------
@app.route('/delete/<string:id_data>', methods = ['GET'])
def delete(id_data):
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        cur = mysql.connection.cursor()
        cur.execute("DELETE FROM `items` WHERE `item_id`=%s", (id_data,))
        mysql.connection.commit()
        return redirect(url_for('home'))
#------------------------------------------------------------------------------------
@app.route('/Home')
def home():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        if session['position']=='Admin':
            name=session['username']
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute("""SELECT * FROM `users` WHERE `last_name`= %s""",(name,))
            row = cursor.fetchall()
            return render_template('/Admin/dashboard.html',user_data=row,username=session['username'], user=session['user'],id=session['id']) 
        else:
            user = session['id']
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute("SELECT * FROM `request` WHERE user_id=%s",(user,))
            req = cursor.fetchall()
            name=session['username']
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute("""SELECT * FROM `users` WHERE `last_name`= %s""",(name,))
            row = cursor.fetchall()
            return render_template('/dashboard.html',user_data=row,requests=req, username=session['username'], user=session['user'],id=session['id']) 
#------------------------------------------------------------------------------------
@app.route('/register')
def register():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        return render_template('/Admin/register.html',username=session['username'], user=session['user'])
#------------------------------------------------------------------------------------
@app.route('/borrow')
def borrow():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        name = session['username']
        email = session['email']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM `users` WHERE email = %s AND last_name = %s', (email, name))
        row = cursor.fetchone()
        if row:
            # Create session data
                user=session['first_name'] = row['first_name']
                username= session['last_name'] = row['last_name']
                session['email'] = row['email']
        return render_template('/forms-layouts.html',first_name=session['first_name'],last_name=session['last_name'],id=session['id'],email=session['email'],username=username)
#------------------------------------------------------------------------------------
@app.route('/form3')
def form3():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        return render_template('/Admin/forms-validation.html',username=session['username'], user=session['user'])
#------------------------------------------------------------------------------------
@app.route('/comment')
def comment():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("""SELECT comments.id,comments.contents, users.email   
                        FROM comments  
                        INNER JOIN users  
                        ON comments.name_id = users.id  
                        ORDER BY id;  """)
        data1 = cursor.fetchall()
        return render_template('/Admin/comment.html', data=data1,username=session['username'], user=session['user'])
#------------------------------------------------------------------------------------
@app.route('/table')
def table():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        return render_template('/Admin/tables-general.html',username=session['username'], user=session['user'])
#------------------------------------------------------------------------------------
@app.route('/add_comment')
def add_comment():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        username= session['last_name']
        return render_template('/comments.html',user_id=session['id'], user_email=session['email'],username=username)
#------------------------------------------------------------------------------------
@app.route('/tabs')
def tabs():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        return render_template('/Admin/components-tabs.html',username=session['username'], user=session['user'])
#------------------------------------------------------------------------------------
@app.route('/modal')
def modal():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        return render_template('/Admin/components-modal.html',username=session['username'], user=session['user'])
#------------------------------------------------------------------------------------
@app.route('/register_item', methods=['POST'])
def register_item():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:  
        if request.method == "POST":
            name = request.form['item_name']
            codification = request.form['codification']
            serial = request.form['serial']
            category = request.form['category']  
            location = request.form['location']
            status = request.form['status']
            cursor = mysql.connection.cursor()
            data = cursor.execute("""INSERT INTO `items`(`item_name`, `item_code`, `item_serial_number`, `item_category`, `item_status`, `item_location`)
            VALUES (%s,%s,%s,%s,%s,%s)""",(name,codification,serial,category,status,location))  
            mysql.connection.commit()      
            return redirect(url_for('home'))
#------------------------------------------------------------------------------------
@app.route('/register_item1', methods=['POST'])
def register_consumable_item():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:  
        if request.method == "POST":
            flash('data inserted successfully')
            name = request.form['item_name']
            quantity = int(request.form['Quantity'])   # convert quantity to integer
            category = request.form['category']  
            location = request.form['location']
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute('SELECT * FROM `items` WHERE `item_name`=%s AND `item_location`=%s', (name,location))
            row = cursor.fetchone()
            if row:
                current_quantity = row['item_quantity']
                final_quantity = int(current_quantity) + quantity
                cursor.execute("""UPDATE `items` SET `item_quantity`=%s WHERE `item_name`=%s AND `item_location`=%s""",
                            (final_quantity, name, location))
            else:
                cursor.execute("""INSERT INTO `items`(`item_name`, `item_quantity`, `item_category`, `item_location`)
                                VALUES (%s, %s, %s, %s)""",
                            (name, quantity, category, location))
            mysql.connection.commit() 
            
            return redirect(url_for('home'))
#------------------------------------------------------------------------------------
@app.route('/register_user', methods=['POST'])
def register_user(): 
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else: 
        if request.method == "POST":
            fname = request.form['name']
            lname = request.form['username']
            email = request.form['email']
            password1 = request.form['password']
            password = generate_password_hash(password1)
            job_position = request.form['job_position']
            cursor = mysql.connection.cursor()
            data = cursor.execute("""INSERT INTO `users`(`first_name`, `last_name`, `email`, `password`, `job_position`)
            VALUES (%s,%s,%s,%s,%s)""",(fname,lname,email,password ,job_position))  
            mysql.connection.commit()      
            return redirect(url_for('home'))   
#------------------------------------------------------------------------------------
@app.route('/data1')
def non_consumabe_data():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("SELECT * FROM `items` WHERE `item_category`='non-consumables'")
        data1 = cursor.fetchall()
        return render_template('/Admin/tables-data.html',data=data1,username=session['username'], user=session['user'])
        cursor.close()
#------------------------------------------------------------------------------------
@app.route('/Consumables')
def consumabe_data():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("SELECT * FROM `items` WHERE `item_category`='consumables'")
        items = cursor.fetchall()
        return render_template('/Admin/tables-general.html',data=items,username=session['username'], user=session['user'])
        cursor.close()
#------------------------------------------------------------------------------------
@app.route('/users')
def users():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("SELECT * FROM `users` WHERE `job_position` != 'Admin'")
        items = cursor.fetchall()
        return render_template('/Admin/all_user.html',data=items,username=session['username'], user=session['user'])
        cursor.close()
#------------------------------------------------------------------------------------
@app.route('/hello')
def hello():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        user = session['username']
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("SELECT * FROM `users` WHERE `last_name`=%s", (user,))
        info = cursor.fetchall()
        return render_template('/dashboard.html', username=session['username'], user=session['user'], information=info)
#------------------------------------------------------------------------------------
@app.route('/non-data')
def non_consumabe_data_for_user():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("SELECT * FROM `items` WHERE `item_category`='non-consumables'")
        data1 = cursor.fetchall()
        return render_template('/tables-data.html',data=data1,username=session['username'], user=session['user'])
        cursor.close()
#------------------------------------------------------------------------------------
@app.route('/Consu')
def consumabe_data_for_use():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("SELECT * FROM `items` WHERE `item_category`='consumables'")
        items = cursor.fetchall()
        return render_template('/table-general.html',data=items,username=session['username'], user=session['user'])
        cursor.close()
#------------------------------------------------------------------------------------
@app.route('/request_item', methods=['POST'])
def request_item():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:       
        if request.method == "POST":
            user_i = request.form['id']
            user_id = int(user_i)
            phone = request.form['phone']
            purpose=request.form['purpose']
            item = request.form['item']
            Quantity = request.form['Quantity']
            cursor = mysql.connection.cursor()
            data = cursor.execute("""INSERT INTO `request`(`user_id`, `phone`, `item_name`, `item_quantity`,`purpose`)
            VALUES (%s,%s,%s,%s,%s)""",(user_id,phone,item,Quantity,purpose))  
            mysql.connection.commit()      
            return redirect(url_for('home'))
#------------------------------------------------------------------------------------  
@app.route('/add_comment', methods=['POST'])
def register_add_comment():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:  
        if request.method == "POST":
            user_id = request.form['id']
            content = request.form['contents']
            cursor = mysql.connection.cursor()
            data = cursor.execute("""INSERT INTO `comments`( `name_id`, `contents`)
            VALUES (%s,%s)""",(user_id,content))  
            mysql.connection.commit()      
            return redirect(url_for('home'))
#----------------------------------------------------------------------------------
@app.route('/update/<string:id_data>', methods=['GET'])
def update(id_data):
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM `items` WHERE item_id=%s', (id_data,))
        account = cursor.fetchall()
        return render_template('/Admin/update_item.html',data=account, id=id_data,username=session['username'], user=session['user'])
#------------------------------------------------------------------------------------
@app.route('/update_item',methods=['POST','GET'])
def update_item():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:

        if request.method == 'POST':
            id_data = request.form['item_id']
            name = request.form['item_name']
            quantity = request.form['item_quantity']
            category = request.form['category']
            location = request.form['location']
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute("""
                UPDATE `items` SET 
                `item_name`=%s,
                `item_quantity`=%s,
                `item_category`=%s,
                `item_location`=%s
                WHERE `item_id`=%s
                """, (name, quantity, category, location,id_data))
            mysql.connection.commit()
            return redirect(url_for('home'))  
#------------------------------------------------------------------------------------
@app.route('/update_non_consumable/<string:id_data>', methods=['GET'])
def update_non_consumable(id_data):
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM `items` WHERE item_id=%s', (id_data,))
        account = cursor.fetchall()
        return render_template('/Admin/update_item_non_consumable.html',data=account, id=id_data,username=session['username'], user=session['user'])
#----------------------------------------------------------------------------------
@app.route('/update_non_consumable_item',methods=['POST','GET'])
def update_item_non_consumable():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        if request.method == 'POST':
            id_data = request.form['item_id']
            name = request.form['item_name']
            item_code = request.form['item_code']
            item_serial_number = request.form['item_serial_number']
            status = request.form['status']
            category = request.form['category']
            location = request.form['location']
            borrowed_to=request.form['borrowed_to']
            availablity = request.form['availablity']
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute("""
                UPDATE `items` SET 
                `item_name`=%s,
                `item_code`=%s,
                `item_serial_number`=%s,
                `item_category`=%s,
                `item_status`=%s,
                `availablity`=%s,
                `item_location`=%s,
                `borrowed_to`=%s
                WHERE `item_id`=%s
                """, (name, item_code,item_serial_number,category,status,availablity, location,borrowed_to,id_data))
            mysql.connection.commit()
            return redirect(url_for('home'))
#----------------------------------------------------------------------------------
@app.route('/delete_user/<string:id_data>', methods = ['GET'])
def delete_user(id_data):
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        cur = mysql.connection.cursor()
        cur.execute("DELETE FROM `users` WHERE `id`=%s", (id_data,))
        mysql.connection.commit()
        return redirect(url_for('home'))
#----------------------------------------------------------------------------------
#------------------------------------------------------------------------------------
@app.route('/update_user/<string:id_data>', methods=['GET'])
def update_user(id_data):
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute('SELECT * FROM `users` WHERE id=%s', (id_data,))
        account = cursor.fetchall()
        return render_template('/Admin/update_user_info.html',data=account, id=id_data,username=session['username'], user=session['user'])
#----------------------------------------------------------------------------------
@app.route('/update_user_info',methods=['POST','GET'])
def update_user_info():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:

        if request.method == 'POST':
            id=request.form['id']
            fname = request.form['name']
            lname = request.form['username']
            email = request.form['email']
            password1 = request.form['password']
            password = generate_password_hash(password1)
            job_position = request.form['job_position']
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute("""
                UPDATE `users` SET 
                `first_name`=%s,
                `last_name`=%s,
                `email`=%s,
                `password`=%s,
                `job_position`=%s
                WHERE `id`=%s
             """, (fname,lname,email,password,job_position,id))
            mysql.connection.commit()
            return redirect(url_for('home'))
#----------------------------------------------------------------------------------
@app.route('/update_your_info',methods=['POST','GET'])
def update_your_info():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        if request.method == 'POST':
            id=request.form['id']
            fname = request.form['fName']
            lname = request.form['lName']
            email = request.form['email']
            Phone=request.form['Phone']
            job_position = request.form['job']
            file = request.files['image']
            filename = file.filename
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute("""
                UPDATE `users` SET 
                `first_name`=%s,
                `last_name`=%s,
                `email`=%s,
                `phone`=%s,
                `job_position`=%s,
                `profile_img`=%s
                WHERE `id`=%s
                """, (fname,lname,email,Phone,job_position,filename,id))
            mysql.connection.commit()
            return redirect(url_for('home'))     
#---------------------------------------------------------------------------------
@app.route('/update_request_status_to_approved/<int:id>')
def change_status_approved(id):
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        cursor = mysql.connection.cursor()
        cursor.execute("""UPDATE `request` SET `status`='approved',`message`='your request have been approved, you should come to our office to take what you requested!' WHERE `id`=%s""", (id,))  
        mysql.connection.commit()
        return redirect(url_for('home'))
#---------------------------------------------------------------------------------
@app.route('/update_request_to_rejected/<int:id>')
def update_request_to_rejected(id):
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
        cursor.execute("""UPDATE `request` SET `status`='rejected', `message`='your request is reject due to unavailablity of item you requested' WHERE `id`=%s""", (id,))  
        mysql.connection.commit()
        return redirect(url_for('home'))
#------------------------------------------------------------------------------------
@app.route('/pending')
def pending():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        if session['position']=='Admin':
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute("""SELECT request.id,request.status,request.user_id,request.phone,
            request.item_name,request.item_quantity,request.purpose,users.first_name,
            users.last_name, users.email FROM request  
            INNER JOIN users ON request.user_id = users.id  
            WHERE `status`='Pending'""")
            row = cursor.fetchall()
            return render_template('/Admin/pending.html',requests=row,username=session['username'], user=session['user']) 
#------------------------------------------------------------------------------------
@app.route('/approved')
def approved():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        if session['position']=='Admin':
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute("""SELECT request.id,request.status,request.user_id,request.phone,
            request.item_name,request.item_quantity,users.first_name,
            users.last_name, users.email FROM request  
            INNER JOIN users ON request.user_id = users.id  
            WHERE `status`='approve'""")
            row = cursor.fetchall()
            return render_template('/Admin/approved.html',requests=row,username=session['username'], user=session['user']) 
#------------------------------------------------------------------------------------
@app.route('/rejected')
def rejected():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        if session['position']=='Admin':
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute("""SELECT request.id,request.status,request.user_id,request.phone,
            request.item_name,request.item_quantity,users.first_name,
            users.last_name, users.email FROM request  
            INNER JOIN users ON request.user_id = users.id  
            WHERE `status`='rejecte'""")
            row = cursor.fetchall()
            return render_template('/Admin/rejected.html',requests=row,username=session['username'], user=session['user'])
#----------------------------------------------------------------------------------
@app.route('/update_user_password', methods=['POST','GET'])
def update_user_pass():
    if len(session) == 0:
        flash('You must login first!', 'error')
        return render_template('index.html')
    else:
        if request.method == 'POST':
            id = request.form['id']
            current_pass = request.form['password']
            new_pass = request.form['newpassword']
            confirm_pass = request.form['renewpassword']
            password = generate_password_hash(new_pass)       
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute('SELECT * FROM `users` WHERE id = %s', [id])
            account = cursor.fetchone()
            passd = account['password']
            if check_password_hash(passd,current_pass):
                if new_pass == confirm_pass:
                    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
                    cursor.execute("""
                        UPDATE `users` SET
                        `password`=%s
                        WHERE id=%s
                    """, (password, id,))
                    mysql.connection.commit()
                    flash('Password changed successfully!', 'success')
                    return redirect(url_for('profile'))
                else:
                    flash("Passwords don't match", 'error')
                    return redirect(url_for('profile'))
            else:
                flash('Current password is incorrect', 'error')
                return redirect(url_for('profile'))
        return render_template('/users-profile.html')
#------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------
if __name__ == '__main__':
    app.run(debug=True)