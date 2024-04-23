

with open('CRUD запросы/Practice.sql', 'r', encoding='utf-8') as f_in:
            data = f_in.read()

with open('CRUD запросы/Practice.sql'.replace('.sql', '_utf-8.sql'), 'w', encoding='utf-8') as f_out:
            f_out.write(data)