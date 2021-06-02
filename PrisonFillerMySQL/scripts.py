from random import randrange
from datetime import timedelta
import random
import datetime
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt


# s = int(abs(np.random.normal(0,20)))             #<= mean = 3, variance = 4
s = np.random.normal(0,20,1000)
print(s)
AA1_plot  = sns.distplot(s, kde=True, rug=False)
plt.show()

# U.S. Passport numbers must be between six and nine alphanumeric characters (letters and numbers).
#files
male_names = open('male_names.txt','r').read().split('\n')
surnames = open('surnames.txt','r').read().split('\n')
crimes = open('crimes.txt','r').read().split('\n')
diseases = open('disease.txt','r').read().split('\n')
addresses = open('addresses.txt','r').read().split('\n')

#dates
now_date = datetime.datetime.now()
max_release_date = datetime.datetime(2060,1,1,0,0,0)
max_birth_date = datetime.datetime(1999,1,1,0,0,0)
prison_opening_date = datetime.datetime(1960,1,1,0,0,0)
min_birth_date = datetime.datetime(1945,1,1,0,0,0)

jobs = ['kitchen','laundry','cleaning','workshop','commisary','cutting grass','','','','','']
specialization = ['oculist','laryngologist','gastrologist','general','family','allergologist','surgeon','dermatologist','genetics','cardiologist','speech therapist','neurologist']
deposit_objects = ['shirt','coat','trousers','shoes','training shoes','suit','glasses','cap','underwear',
                   'jacket','keys','wallet','credit card','passport','id','driving license','cash','pennies','family photo',
                   'pocket knife', 'knife','gun','baseball bat','machette','brass knuckles','blouse','socks','gloves','phone',
                   'headphones','earpiece','ring','signet ring']
max_bed_count = 8

verbs = ['hit', 'cursed on', 'possesed', 'stole', 'smashed', 'burned', 'dent', 'broke', 'abused', 'punched',
         'escaped from' ,'spit on', 'bit', 'scrached']
nouns = ['jailer', 'inmate', 'prisoner', 'visitor', 'prison warden', 'doctor', 'warden', ' prison governor', 'bed',
         'wall','floor', 'ceiling', 'bars', 'plates', 'knife', 'spoon', 'fork', 'clothes', 'shower', 'toilet', 'glass','drugs',
         'marihuana', 'ecstasy', 'cocaine', 'dinner', 'breakfest', 'lunch','jacket', 'shirt','shoes', 'friend','table' ,'chair']

def random_datetime(start, end):
    """
    This function will return a random datetime between two datetime
    objects.
    """
    delta = end - start
    int_delta = (delta.days * 24 * 60 * 60) + delta.seconds
    random_second=0
    if int_delta!=0:
        random_second = randrange(int_delta)
    else: random_second=1
    return start + timedelta(seconds=random_second)

def max_datetimes(d1, d2):
    if d1>=d2:
        return d1;
    else: return d2;

def min_datetimes(d1, d2):
    if d1<d2:
        return d1;
    else: return d2;

def random_date(start, end):
    return random_datetime(start, end).strftime('%Y-%m-%d');

def to_str(date_and_time):
    date_and_time.strftime('%Y-%m-%d')

def to_date(date_str):
    return datetime.datetime.strptime(date_str, '%Y-%m-%d')

def random_name():
    return random.choice(male_names)

def random_surname():
    return random.choice(surnames)

def random_passport_number():
    return str(random.randint(100000,9999999999))

def random_job_assignment():
    return random.choice(jobs)

def random_crime():
    return random.choice(crimes)

def random_is_dangerous():
    return random.randint(0,1)

def random_bed_count():
    return random.randint(0, max_bed_count)
def random_reprimand_content(name):
    return name +' '+random.choice(verbs)+' '+random.choice(nouns)+"."
def random_complaint_content(name, surname):
    nouns = ['jailer', 'visitor', 'prison warden', 'bed','wall',
             'floor', 'ceiling', 'bars', 'plates', 'knife', 'spoon', 'fork', 'clothes', 'glass',
             'drugs', 'marihuana','ecstasy', 'cocaine', 'dinner', 'breakfest', 'lunch', 'jacket', 'shirt','shoes','friend', 'table' ,'chair']
    return name +' ' +surname+" "+random.choice(verbs)+' my '+random.choice(nouns)+"."

def random_health_description():
    verbs = ['has got','doesnt have','has']
    nouns = ['disease','problem']
    return 'Patient '+random.choice(verbs)+' '+random.choice(diseases)+' '+random.choice(nouns)+'.'

def random_shipper_receiver():
    return random_name()+ ' '+random_surname()+' '+random.choice(addresses)

def random_blocks(number):
    blocks=[]
    for i in range(number):
        blocks.append((random_is_dangerous(),))
    return blocks

def random_cells(num_cells_per_block,num_blocks,min_block_id):
    cells=[]
    for i in range(num_cells_per_block*num_blocks):
        cells.append((random_bed_count(),int(i/num_cells_per_block)+min_block_id))
    return cells

def random_prisoners(num_prisoners, cells, min_cell_id):
    prisoners=[]
    cellsBedsFree=[0]*len(cells)
    cell_count=0
    prisoners_count=0

    for i in range(len(cells)):
        cellsBedsFree[i] = cells[i][0];

    for i in range(num_prisoners):
        birth_date = random_datetime(min_birth_date, max_birth_date)
        min_admission_date = birth_date + timedelta(seconds=18 * 365 * 24 * 60 * 60)
        admission_date = random_datetime(min_admission_date, now_date - timedelta(seconds=24*60*60))
        release_date = random_datetime(admission_date, admission_date + timedelta(days=365*int(abs(np.random.normal(0,20)))))

        cell_id = random.randint(0, len(cells) - 1)
        if release_date>now_date:
            while cellsBedsFree[cell_id]<=0:
                cell_id = random.randint(0, len(cells) - 1)

            cellsBedsFree[cell_id]-=1;

        # (bed_count, _) = cells[cell_count]
        # if(prisoners_count+1>=bed_count):
        #     cell_count+=1
        #     prisoners_count=-1
        # prisoners_count+=1

        prisoners.append((random_name(), random_surname(), random_passport_number(),
                          birth_date.strftime('%Y-%m-%d'), admission_date.strftime('%Y-%m-%d'),
                          release_date.strftime('%Y-%m-%d'),random_job_assignment(), random_crime(), random_is_dangerous(),cell_id + min_cell_id))
    print(cellsBedsFree)
    return prisoners

def random_isolation_cells(num_isolation_cells_per_block,num_blocks, min_block_id):
    isolation_cells=[]
    for i in range(num_isolation_cells_per_block*num_blocks):
        isolation_cells.append((int(i/num_isolation_cells_per_block)+min_block_id,))
    return isolation_cells

def random_isolations(num_isolations,prisoners,min_isolation_cell_id, isolation_cells,min_prisoner_id):
    isolations=[]
    isolation_cell_index=0
    isolation_cell_max_index = len(isolation_cells)-2

    for i in range(num_isolations):
        prisoner_id= random.randint(0,len(prisoners)-1)

        (_, _, _, _, prisoner_admission_date,prisoner_release_date, _, _, _, _) = prisoners[prisoner_id]
        prisoner_admission_date = datetime.datetime.strptime(prisoner_admission_date, '%Y-%m-%d')
        prisoner_release_date = datetime.datetime.strptime(prisoner_release_date, '%Y-%m-%d')

        last_possible_start_date=datetime.datetime.now() - timedelta(seconds=60 * 24 * 60 * 60)
        if now_date>prisoner_release_date:
            last_possible_start_date=prisoner_release_date - timedelta(seconds=60 * 24 * 60 * 60)
        start_date = random_datetime(prisoner_admission_date,now_date)
        finish_date = random_datetime(start_date,start_date + timedelta(seconds=60 * 24 * 60 * 60))

        index = random.randint(0,isolation_cell_max_index)
        for i in range(len(isolations)):
            if isolations[i][3]-min_isolation_cell_id == index and abs((to_date(isolations[i][0])-start_date).days)<61:
                # print(isolations[i][3])
                index = random.randint(0, isolation_cell_max_index)
                while isolations[i][3]-min_isolation_cell_id  == index  and abs((to_date(isolations[i][0])-start_date).days)<61:
                    index = random.randint(0, isolation_cell_max_index)

        isolations.append((start_date.strftime('%Y-%m-%d'),finish_date.strftime('%Y-%m-%d'),prisoner_id+min_prisoner_id,index+min_isolation_cell_id))

    return isolations
def random_jailers(num_jailers):
    jailers=[]
    for i in range(num_jailers):
        employment_date = random_datetime(prison_opening_date,now_date)
        layoff_date = random_datetime(employment_date,now_date)
        if(random.uniform(0,1)>float((now_date - employment_date).days/(60*365))):
            layoff_date =None
        else:
            layoff_date = layoff_date.strftime('%Y-%m-%d')
        jailers.append((random_name(),random_surname(),random_passport_number(),employment_date.strftime('%Y-%m-%d'),layoff_date))

    return jailers

def random_duties(last_duty_date,num_blocks, min_block_id):
    duties=[]
    num_duties_per_block = (now_date-last_duty_date).days * 3
    start_date = last_duty_date
    for i in range(num_duties_per_block):
        for j in range(num_blocks):
            duties.append((start_date.strftime('%Y-%m-%d %H-%M-%S'), (start_date + timedelta(seconds=8*60*60)).strftime('%Y-%m-%d %H-%M-%S'),j+min_block_id))

        start_date = start_date + timedelta(seconds=8*60*60)
    return duties

def random_shifts(max_jailers_per_duty,duties, min_duty_id,jailers,min_jailer_id):
    shifts=[]
    jailer_index=0
    last_jailer_index=0;
    for i in range(len(duties)):
        for j in range(max_jailers_per_duty):
            for z in range(jailer_index,len(jailers)):
                (_,_,_,_,layoff_date) = jailers[z]
                if layoff_date==None:
                    shifts.append((i + min_duty_id, z + min_jailer_id))
                    last_jailer_index=z
                    break

            jailer_index = last_jailer_index + 1
            if jailer_index>=len(jailers)-1:
                jailer_index=0

    return shifts

def random_reprimands(num_reprimands,prisoners,min_prisoner_id,jailers,min_jailer_id):
    reprimands=[]
    for i in range(num_reprimands):

        prisoner_id = random.randint(0, len(prisoners)-1)
        (_, _, _, _, prisoner_admission_date,prisoner_release_date, _, _, _, _) = prisoners[prisoner_id]
        admission_date = datetime.datetime.strptime(prisoner_admission_date, '%Y-%m-%d')
        release_date = datetime.datetime.strptime(prisoner_release_date, '%Y-%m-%d')

        last_reprimand_date = now_date
        if release_date < now_date:
            last_reprimand_date = release_date

        jailer_id = random.randint(0, len(jailers)-1)

        (_, _, _,employment_date,layoff_date) = jailers[jailer_id]
        employment_date = datetime.datetime.strptime(employment_date, '%Y-%m-%d')
        if layoff_date == None: layoff_date = now_date
        else: layoff_date = datetime.datetime.strptime(layoff_date, '%Y-%m-%d')

        while employment_date>last_reprimand_date or layoff_date < admission_date:
            jailer_id = random.randint(0, len(jailers)-1)
            (_, _, _, employment_date,layoff_date) = jailers[jailer_id]
            employment_date = datetime.datetime.strptime(employment_date, '%Y-%m-%d')
            if layoff_date == None: layoff_date = now_date
            else: layoff_date = datetime.datetime.strptime(layoff_date, '%Y-%m-%d')


        first_reprimand_date = max_datetimes(employment_date,admission_date)
        last_reprimand_date = min_datetimes(last_reprimand_date,layoff_date)
        reprimand_date = random_date(first_reprimand_date,last_reprimand_date)
        reprimands.append((reprimand_date,random_reprimand_content(prisoners[prisoner_id][0]),jailer_id+min_jailer_id,prisoner_id + min_prisoner_id))
    return reprimands

def random_complaints(num_complaints, prisoners,min_prisoner_id, jailers):
    complaints=[]
    for i in range(num_complaints):
        name=''
        surname=''
        if random.uniform(0,1)<0.5:
            prisoner=random.choice(prisoners)
            (name,surname,_,_,_,_,_,_,_,_) = prisoner
        else:
            jailer = random.choice(jailers)
            (name, surname,_,_,_) = jailer

        prisoner_index = random.randint(0,len(prisoners)-1)
        first_date = to_date(prisoners[prisoner_index][4])
        last_date = to_date(prisoners[prisoner_index][5])
        if last_date>now_date:
            last_date=now_date

        complaints.append((random_complaint_content(name, surname),random_date(first_date,last_date),prisoner_index+min_prisoner_id))
    return complaints

def random_doctors(num_doctors):
    doctors=[]
    for i in range(num_doctors):
        doctors.append((random_name(),random_surname(),random.choice(specialization)))
    return doctors

def random_infirmary_visits(num_infirmary_visits, prisoners,min_prisoner_id,num_doctors, min_doctor_id):
    infirmary_visits=[]
    for i in range(num_infirmary_visits):
        doctor_index=random.randint(0,num_doctors-1)
        prisoner_index = random.randint(0,len(prisoners)-1)
        first_date = to_date(prisoners[prisoner_index][4])
        last_date = to_date(prisoners[prisoner_index][5])
        if last_date>now_date:
            last_date=now_date

        infirmary_visits.append((random_datetime(first_date,last_date),random_health_description(),prisoner_index+min_prisoner_id,doctor_index + min_doctor_id))
    return infirmary_visits

def random_packages(num_packages, prisoners, min_prisoner_id):
    packages=[]
    for i in range(num_packages):
        prisoner_index = random.randint(0,len(prisoners)-1)
        first_date = to_date(prisoners[prisoner_index][4])
        last_date = to_date(prisoners[prisoner_index][5])
        if last_date>now_date:
            last_date=now_date
        prison_adress = prisoners[prisoner_index][0]+' '+prisoners[prisoner_index][1] +', Washington State Penitentiary, 1313 N 13th Ave, Walla Walla, WA 99362,'
        shipper=''
        receiver=''
        if random.uniform(0,1)<0.5:
            shipper=random_shipper_receiver()
            receiver = prison_adress
        else:
            shipper = prison_adress
            receiver = random_shipper_receiver()

        packages.append((random_datetime(first_date,last_date),shipper, receiver,prisoner_index+min_prisoner_id))
    return packages

def random_deposits(prisoners,min_prisoner_id):
    deposits=[]
    for i in range(len(prisoners)):
        admission_date = to_date(prisoners[i][4])
        deposits.append((admission_date,i+min_prisoner_id))
    return deposits

def random_objects(max_objects_per_deposit, deposits, min_deposits_id):
    objects = []
    for i in range(len(deposits)):
        num_objects = random.randint(3,max_objects_per_deposit)
        temp_deposit_objects=deposit_objects.copy()
        for j in range(num_objects):
            object_name = random.choice(temp_deposit_objects)
            temp_deposit_objects.remove(object_name)
            objects.append((object_name, i + min_deposits_id))
    return objects

def random_passes(num_passes,max_pass_days,prisoners, min_prisoner_id):
    passes=[]
    for i in range(num_passes):
        prisoner_index = random.randint(0,len(prisoners)-1)
        start_date = random_datetime(to_date(prisoners[prisoner_index][4]),now_date);
        days = random.randint(1,max_pass_days)
        finish_date = start_date + timedelta(days=days)
        passes.append((start_date,finish_date, prisoner_index + min_prisoner_id))
    return passes

def random_vistors(num_visitors):
    visitors = []
    for i in range(num_visitors):
        visitors.append((random_name(), random_surname(), random_passport_number(),random.choice(addresses)))
    return visitors

def random_prisoner_visits(num_prisoner_visits,num_visitors, prisoners,min_prisoner_id, min_visitor_id):
    prisoner_visits=[]
    for i in range(num_prisoner_visits):
        visitor_index=random.randint(0,num_visitors-1)
        prisoner_index = random.randint(0,len(prisoners)-1)
        first_date = to_date(prisoners[prisoner_index][4])
        last_date = to_date(prisoners[prisoner_index][5])
        if last_date>now_date:
            last_date=now_date

        prisoner_visits.append((random_datetime(first_date,last_date),random.randint(5,60),prisoner_index+min_prisoner_id,visitor_index + min_visitor_id))
    return prisoner_visits

a = datetime.datetime(2000,5,14,13,11,11)
b = datetime.datetime(2000,5,18,11,12,15)
print((a-b).days)