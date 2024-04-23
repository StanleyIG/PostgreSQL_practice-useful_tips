import os
import codecs

sql_scripts_lst = ['CASE.sql', 'GROUP_BY_HAVING.sql', 'JOIN.sql', 'L_R_I_JOIN.sql', 'LIKE_AND_OR.sql',
                   'ORDER_BY.sql', 'practice_first_module.sql', 'Practice.sql', 'SQLQuery1.sql']

def convert(file_path):
    try:
        with codecs.open(file_path, 'r', encoding='windows-1251') as f_in:
            data = f_in.read()

        with codecs.open(file_path.replace('.sql', '_utf-8.sql'), 'w', encoding='utf-8') as f_out:
            f_out.write(data)

        os.remove(file_path)
    except UnicodeDecodeError:
        pass

for sql_script in sql_scripts_lst:
    convert(f'CRUD запросы/{sql_script}')
