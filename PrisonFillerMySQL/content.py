import mysql.connector
import datetime
import scripts as sc
from datetime import timedelta
import time

# połączenie z mysql serverem
mydb = mysql.connector.connect(
    host = 'localhost',
    user = 'root',
    password= 'wroclaw14',
    database='prison'
)

mydb.autocommit=True
mycursor = mydb.cursor()

# liczby różnych rekordów
num_prisoners=10000
num_blocks = 30
num_cells_per_block = 100
num_isolation_cells_per_block=10
num_isolation_cells = num_isolation_cells_per_block * num_blocks;
num_isolations=3000
num_jailers= 500
last_duty_date = datetime.datetime(2019,10,1,0,0,0)
max_jailers_per_duty = 4
num_reprimands=20000
num_complaints=10000
num_doctors=100
num_infirmary_visits=10000
num_packages=5000
num_deposits=num_prisoners
max_objects_per_deposit=10
num_passes=5000
max_pass_days=9
num_visitors=10000
num_prisoner_visits=20000

# lines 40-150 to zapytania o maksymalne indexy w każdej tabelce by wiedzieć jakie indexy będą miały klucze po auto inkrementacii
# (tu nie ustalam ich indeksu w bazie)
mycursor.execute("select max(block_id) from block;")
(min_block_id,) = mycursor.fetchall()[0]
if min_block_id==None:
    min_block_id=0
    mycursor.execute("ALTER TABLE block AUTO_INCREMENT = 1")
min_block_id+=1

mycursor.execute("select max(prisoner_id) from prisoner;")
(min_prisoner_id,) = mycursor.fetchall()[0]
if min_prisoner_id==None:
    min_prisoner_id=0
    mycursor.execute("ALTER TABLE prisoner AUTO_INCREMENT = 1")
min_prisoner_id+=1

mycursor.execute("select max(cell_id) from cell;")
(min_cell_id,) = mycursor.fetchall()[0]
if min_cell_id==None:
    min_cell_id=0
    mycursor.execute("ALTER TABLE cell AUTO_INCREMENT = 1")
min_cell_id+=1

mycursor.execute("select max(isolation_cell_id) from isolation_cell;")
(min_isolation_cell_id,) = mycursor.fetchall()[0]
if min_isolation_cell_id==None:
    min_isolation_cell_id=0
    mycursor.execute("ALTER TABLE isolation_cell AUTO_INCREMENT = 1")
min_isolation_cell_id+=1

mycursor.execute("select max(isolation_id) from isolation;")
(min_isolation_id,) = mycursor.fetchall()[0]
if min_isolation_id==None:
    min_isolation_id=0
    mycursor.execute("ALTER TABLE isolation AUTO_INCREMENT = 1")
min_isolation_id+=1

mycursor.execute("select max(jailer_id) from jailer;")
(min_jailer_id,) = mycursor.fetchall()[0]
if min_jailer_id==None:
    min_jailer_id=0
    mycursor.execute("ALTER TABLE jailer AUTO_INCREMENT = 1")
min_jailer_id+=1

mycursor.execute("select max(duty_id) from duty;")
(min_duty_id,) = mycursor.fetchall()[0]
if min_duty_id==None:
    min_duty_id=0
    mycursor.execute("ALTER TABLE duty AUTO_INCREMENT = 1")
min_duty_id+=1

mycursor.execute("select max(shift_id) from shift;")
(min_shift_id,) = mycursor.fetchall()[0]
if min_shift_id==None:
    min_shift_id=0
    mycursor.execute("ALTER TABLE shift AUTO_INCREMENT = 1")
min_shift_id+=1

mycursor.execute("select max(reprimand_id) from reprimand;")
(min_reprimand_id,) = mycursor.fetchall()[0]
if min_reprimand_id==None:
    min_reprimand_id=0
    mycursor.execute("ALTER TABLE reprimand AUTO_INCREMENT = 1")
min_reprimand_id+=1

mycursor.execute("select max(doctor_id) from doctor;")
(min_doctor_id,) = mycursor.fetchall()[0]
if min_doctor_id==None:
    min_doctor_id=0
    mycursor.execute("ALTER TABLE doctor AUTO_INCREMENT = 1")
min_doctor_id+=1

mycursor.execute("select max(infirmary_visit_id) from infirmary_visit;")
(min_infirmary_visit_id,) = mycursor.fetchall()[0]
if min_infirmary_visit_id==None:
    min_infirmary_visit_id=0
    mycursor.execute("ALTER TABLE infirmary_visit AUTO_INCREMENT = 1")
min_infirmary_visit_id+=1

mycursor.execute("select max(package_id) from package;")
(min_package_id,) = mycursor.fetchall()[0]
if min_package_id==None:
    min_package_id=0
    mycursor.execute("ALTER TABLE package AUTO_INCREMENT = 1")
min_package_id+=1

mycursor.execute("select max(deposit_id) from deposit;")
(min_deposit_id,) = mycursor.fetchall()[0]
if min_deposit_id==None:
    min_deposit_id=0
    mycursor.execute("ALTER TABLE deposit AUTO_INCREMENT = 1")
min_deposit_id+=1

mycursor.execute("select max(object_id) from object;")
(min_object_id,) = mycursor.fetchall()[0]
if min_object_id==None:
    min_object_id=0
    mycursor.execute("ALTER TABLE object AUTO_INCREMENT = 1")
min_object_id+=1

mycursor.execute("select max(pass_id) from pass;")
(min_pass_id,) = mycursor.fetchall()[0]
if min_pass_id==None:
    min_pass_id=0
    mycursor.execute("ALTER TABLE pass AUTO_INCREMENT = 1")
min_pass_id+=1

mycursor.execute("select max(visitor_id) from visitor;")
(min_visitor_id,) = mycursor.fetchall()[0]
if min_visitor_id==None:
    min_visitor_id=0
    mycursor.execute("ALTER TABLE visitor AUTO_INCREMENT = 1")
min_visitor_id+=1

mycursor.execute("select max(prisoner_visit_id) from prisoner_visit;")
(min_prisoner_visit_id,) = mycursor.fetchall()[0]
if min_prisoner_visit_id==None:
    min_prisoner_visit_id=0
    mycursor.execute("ALTER TABLE prisoner_visit AUTO_INCREMENT = 1")
min_prisoner_visit_id+=1


print('min_cell_id '+str(min_cell_id))
print('min_block_id '+str(min_block_id))
print('min_prisoner_id '+str(min_prisoner_id))
print('min_deposit_id '+str(min_deposit_id))
print('min_doctor_id '+str(min_doctor_id))
print('min_duty_id '+str(min_duty_id))
print('min_infirmary_visit_id '+str(min_infirmary_visit_id))
print('min_isolation_cell_id '+str(min_isolation_cell_id))
print('min_isolation_id '+str(min_isolation_id))
print('min_jailer_id '+str(min_jailer_id))
print('min_object_id '+str(min_object_id))
print('min_package_id '+str(min_package_id))
print('min_pass_id '+str(min_pass_id))
print('min_prisoner_visit_id '+str(min_prisoner_visit_id))
print('min_reprimand_id '+str(min_reprimand_id))
print('min_shift_id '+str(min_shift_id))
print('min_visitor_id '+str(min_visitor_id))

# sql formulas
blockFormula = "insert into block (for_dangerous) values (%s)"
cellFormula = "insert into cell (bed_count, block_block_id) values (%s,%s)"
prisonerFormula = "insert into prisoner (prisoner_name, prisoner_surname, passport_number, birth_date,admission_date,release_date,job_assignment,crime, is_dangerous, cell_cell_id) values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)"
isolation_cellFormula = "insert into isolation_cell (block_block_id) values (%s)"
isolationFormula = "insert into isolation (start_date, finish_date, prisoner_prisoner_id, isolation_cell_isolation_cell_id) values (%s,%s,%s,%s)"
jailerFormula = "insert into jailer (jailer_name, jailer_surname, passport_number, employment_date,layoff_date) values (%s,%s,%s,%s,%s)"
dutyFormula = "insert into duty (start_date, finish_date, block_block_id) values (%s,%s,%s)"
shiftFormula = "insert into shift (duty_duty_id, jailer_jailer_id) values (%s,%s)"
reprimandFormula = "insert into reprimand (reprimand_date, contents, jailer_jailer_id, prisoner_prisoner_id) values (%s,%s,%s,%s)"
complaintFormula = "insert into complaint (contents, complaint_date, prisoner_prisoner_id) values (%s,%s,%s)"
doctorFormula = "insert into doctor (doctor_name, doctor_surname, specialization) values (%s,%s,%s)"
infirmary_visitFormula = "insert into infirmary_visit (visit_date, health_description, prisoner_prisoner_id, doctor_doctor_id) values (%s,%s,%s, %s)"
packageFormula = "insert into package (reception_date, shipper, receiver, prisoner_prisoner_id) values (%s,%s,%s, %s)"
depositFormula = "insert into deposit (deposit_date, prisoner_prisoner_id) values (%s,%s)"
objectFormula = "insert into object (object_name, deposit_deposit_id) values (%s,%s)"
passFormula = "insert into pass (start_date, finish_date, prisoner_prisoner_id) values (%s,%s,%s)"
visitorFormula = "insert into visitor (visitor_name, visitor_surname, passport_number, address) values (%s,%s,%s,%s)"
prisoner_visitFormula = "insert into prisoner_visit (visit_date, visit_length_minutes, prisoner_prisoner_id, visitor_visitor_id) values (%s,%s,%s, %s)"

# creating lists with records
blocks = sc.random_blocks(num_blocks)
cells = sc.random_cells(num_cells_per_block,num_blocks,min_block_id)
prisoners = sc.random_prisoners(num_prisoners,cells, min_cell_id)
isolation_cells = sc.random_isolation_cells(num_isolation_cells_per_block, num_blocks, min_block_id)
isolations = sc.random_isolations(num_isolations,prisoners,min_isolation_cell_id,isolation_cells,min_prisoner_id)
jailers = sc.random_jailers(num_jailers)
duties = sc.random_duties(last_duty_date,num_blocks,min_block_id)
shifts = sc.random_shifts(max_jailers_per_duty,duties,min_duty_id,jailers,min_jailer_id)
reprimands = sc.random_reprimands(num_reprimands,prisoners,min_prisoner_id,jailers,min_jailer_id)
complaints = sc.random_complaints(num_complaints, prisoners, min_prisoner_id, jailers)
doctors = sc.random_doctors(num_doctors)
infirmary_visits = sc.random_infirmary_visits(num_infirmary_visits, prisoners, min_prisoner_id,num_doctors, min_doctor_id)
packages = sc.random_packages(num_packages,prisoners,min_prisoner_id)
deposits = sc.random_deposits(prisoners,min_prisoner_id)
objects = sc.random_objects(max_objects_per_deposit, deposits,min_deposit_id)
passes = sc.random_passes(num_passes, max_pass_days, prisoners, min_prisoner_id)
visitors = sc.random_vistors(num_visitors)
prisoner_visits = sc.random_prisoner_visits(num_prisoner_visits,num_visitors, prisoners,min_prisoner_id,min_visitor_id)

# sending records
mycursor.executemany(blockFormula,blocks)
mycursor.executemany(cellFormula,cells)
mycursor.executemany(prisonerFormula,prisoners)
mycursor.executemany(isolation_cellFormula,isolation_cells)
mycursor.executemany(isolationFormula,isolations)
mycursor.executemany(jailerFormula,jailers)
mycursor.executemany(dutyFormula,duties)
mycursor.executemany(shiftFormula,shifts)
mycursor.executemany(reprimandFormula,reprimands)
mycursor.executemany(complaintFormula,complaints)
mycursor.executemany(doctorFormula,doctors)
mycursor.executemany(infirmary_visitFormula,infirmary_visits)
mycursor.executemany(packageFormula,packages)
mycursor.executemany(depositFormula,deposits)
mycursor.executemany(objectFormula,objects)
mycursor.executemany(passFormula,passes)
mycursor.executemany(visitorFormula,visitors)
mycursor.executemany(prisoner_visitFormula,prisoner_visits)
mydb.commit()

