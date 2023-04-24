from datetime import timedelta
from flask import Flask, render_template, request, redirect, url_for, session, flash
from flask_mysqldb import MySQL
import MySQLdb.cursors
from werkzeug.security import generate_password_hash,check_password_hash

app = Flask(__name__)

app.secret_key = 'shardaq'
app.config['PERMANENT_SESSION_LIFETIME']= timedelta(minutes=10)

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
    return render_template('/Admin/users-profile.html')
#------------------------------------------------------------------------------------
@app.route('/Home')
def home():
    if len(session)==0:
        return render_template('index.html',error='you must login first')
    else:
        if session['position']=='Admin':
            cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
            cursor.execute("""SELECT request.id,request.status,request.user_id,request.phone,
            request.item_name,request.item_quantity,users.first_name,
            users.last_name, users.email FROM request  
            INNER JOIN users ON request.user_id = users.id  
            ORDER BY id""")
            row = cursor.fetchall()
            return render_template('/Admin/dashboard.html',requests=row,username=session['username'], user=session['user']) 
        else:
            return render_template('/dashboard.html', username=session['username'], user=session['user']) 
#------------------------------------------------------------------------------------
@app.route('/register')
def register():
    return render_template('/Admin/register.html',username=session['username'], user=session['user'])
#------------------------------------------------------------------------------------
@app.route('/borrow')
def borrow():
    name = session['username']
    email = session['email']
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute('SELECT * FROM `users` WHERE email = %s AND last_name = %s', (email, name))
    row = cursor.fetchone()
    if row:
            # Create session data
            session['first_name'] = row['first_name']
            session['last_name'] = row['last_name']
            session['email'] = row['email']
    return render_template('/forms-layouts.html',first_name=session['first_name'],last_name=session['last_name'],id=session['id'],email=session['email'])
#------------------------------------------------------------------------------------
@app.route('/form3')
def form3():
    return render_template('/Admin/forms-validation.html',username=session['username'], user=session['user'])
#------------------------------------------------------------------------------------
@app.route('/comment')
def comment():
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
    return render_template('/Admin/tables-general.html',username=session['username'], user=session['user'])
#------------------------------------------------------------------------------------
@app.route('/add_comment')
def add_comment():
    return render_template('/comments.html',user_id=session['id'], user_email=session['email'])
#------------------------------------------------------------------------------------
@app.route('/tabs')
def tabs():
    return render_template('/Admin/components-tabs.html',username=session['username'], user=session['user'])
#------------------------------------------------------------------------------------
@app.route('/modal')
def modal():
    return render_template('/Admin/components-modal.html',username=session['username'], user=session['user'])
#------------------------------------------------------------------------------------
@app.route('/register_item', methods=['POST'])
def register_item():  
    if request.method == "POST":
        flash('data inserted successfully')
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
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT * FROM `items` WHERE `item_category`='non-consumables'")
    data1 = cursor.fetchall()
    return render_template('/Admin/tables-data.html',data=data1,username=session['username'], user=session['user'])
    cursor.close()
#------------------------------------------------------------------------------------
@app.route('/Consumables')
def consumabe_data():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT * FROM `items` WHERE `item_category`='consumables'")
    items = cursor.fetchall()
    return render_template('/Admin/tables-general.html',data=items,username=session['username'], user=session['user'])
    cursor.close()
#------------------------------------------------------------------------------------
@app.route('/users')
def users():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT * FROM `users` WHERE `job_position` != 'Admin'")
    items = cursor.fetchall()
    return render_template('/Admin/all_user.html',data=items,username=session['username'], user=session['user'])
    cursor.close()
#------------------------------------------------------------------------------------
@app.route('/hello')
def hello():
    user = session['username']
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT * FROM `users` WHERE `last_name`=%s", (user,))
    info = cursor.fetchall()
    return render_template('/dashboard.html', username=session['username'], user=session['user'], information=info)
#------------------------------------------------------------------------------------
@app.route('/non-data')
def non_consumabe_data_for_user():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT * FROM `items` WHERE `item_category`='non-consumables'")
    data1 = cursor.fetchall()
    return render_template('/tables-data.html',data=data1,username=session['username'], user=session['user'])
    cursor.close()
#------------------------------------------------------------------------------------
@app.route('/Consu')
def consumabe_data_for_use():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT * FROM `items` WHERE `item_category`='consumables'")
    items = cursor.fetchall()
    return render_template('/table-general.html',data=items,username=session['username'], user=session['user'])
    cursor.close()
#------------------------------------------------------------------------------------
@app.route('/request_item', methods=['POST'])
def request_item():  
    if request.method == "POST":
        user_i = request.form['id']
        user_id = int(user_i)
        phone = request.form['phone']
        item = request.form['item']
        Quantity = request.form['Quantity']
        cursor = mysql.connection.cursor()
        data = cursor.execute("""INSERT INTO `request`(`user_id`, `phone`, `item_name`, `item_quantity`)
        VALUES (%s,%s,%s,%s)""",(user_id,phone,item,Quantity))  
        mysql.connection.commit()      
        return redirect(url_for('home'))
#------------------------------------------------------------------------------------  
@app.route('/add_comment', methods=['POST'])
def register_add_comment():  
    if request.method == "POST":
        user_id = request.form['id']
        content = request.form['contents']
        cursor = mysql.connection.cursor()
        data = cursor.execute("""INSERT INTO `comments`( `name_id`, `contents`)
        VALUES (%s,%s)""",(user_id,content))  
        mysql.connection.commit()      
        return redirect(url_for('home'))
#---------------------------------------------------------------------------------

@app.route('/changestatus/<id>/<status>')
def change_status(id, status):
    id = int(id)
    cursor = mysql.connection.cursor()
    cursor.execute("""UPDATE `request` SET `status`=%s WHERE `id`=%s""", (status, id))  
    mysql.connection.commit()
    # cursor.execute("""SELECT request.user_id,users.email   
    #                 FROM request
    #                 INNER JOIN users  
    #                 ON request.user_id = users.id
    #                 WHERE request.id=%s""", (id)) 
    # user = cursor.fetchone()
    # users= user['email']
    # message = ("hello %s, your request has been %s. Thanks!" % (users, status))
    return redirect(url_for('home'))

if __name__ == '__main__':
    app.run(debug=True)