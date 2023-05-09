from flask import Flask, request
from linebot import LineBotApi, WebhookHandler
from linebot.exceptions import InvalidSignatureError
from linebot.models import MessageEvent, TextMessage, TextSendMessage 
import random
import re
import MySQLdb
import json





line_bot = LineBotApi("s0eIY9x50Pvg9pB0l1vTkdvBTwRDY5Su00aCc3Cr4/dwpAIDjJZ4shDINARB5zIDdoHB5k8xj0qfH5g0NyR9/kc04yzlL3KDahnJ5xUubHBjz83DEMlV/Jq1K+6WvId/F6pTPq0heVX/B6skiqtoBQdB04t89/1O/w1cDnyilFU=")
handler = WebhookHandler("2a63d2b015ad8ff0811f6f4cbe49c756")
# 建立 Flask Instance
app = Flask("LineBot")
 
# 定義路由
@app.get("/")
def index():
    return "Hello World"


@app.post("/callback")
def callback():
    # 獲取簽章
    signature: str = request.headers["X-Line-Signature"]
 
    # 獲取請求內容
    body: str = request.get_data(as_text=True)
    print(body)
 
    # 處理事件
    try:
        handler.handle(body, signature)
    except InvalidSignatureError:
        # 若請求內的簽章與計算結果不符則報錯
        return "Invalid signature.", 400

    return "OK"

mode = None
# 宣告變數儲存已選課程代碼和名稱，初值為空字串
selected_courses = []
SIDpass = ""
i=0
msg=["",""]
@handler.add(MessageEvent, message=TextMessage)
def handle_message(event: MessageEvent):
    # 獲取用戶輸入的訊息
    global i
    global SIDpass
    global msg
    msg[i] = event.message.text
    conn = MySQLdb.connect(host="127.0.0.1",
                    user="root",
                    db="sql_test3")
    # 檢查學號是否符合格式要求
    # SID = SIDpass
    if re.match(r'^D\d{7}$', msg[0]):
        # 傳送一個訊息告訴用戶學號符合格式要求
        SIDpass = msg[0]
        
        if i != 1:
            line_bot.reply_message(
                event.reply_token,
                TextSendMessage(text = msg[0]+'您輸入的學號符合格式要求！\n請輸入數字 1.選課 或 2.退選 3.查詢課表 4.查詢可選課表 5.退出')
            )
        i = 1
        # msg[1] = event.message.text
    else:
        # 回覆錯誤訊息
        line_bot.reply_message(
            event.reply_token,
            TextSendMessage(text = "請輸入正確學號格式(DXXXXXXX)")
        )
    global mode, selected_courses
    # 如果目前沒有選擇模式，判斷輸入的數字
    if not mode:
        if msg[1] == "1":
            mode = "select"
            line_bot.reply_message(
                event.reply_token, 
                TextSendMessage(text="請輸入選課代碼:")
            )
        elif msg[1] == "2":
            mode = "withdraw"
            line_bot.reply_message(
                event.reply_token, 
                TextSendMessage(text="請輸入要退選之課堂代碼:")
            )
        elif msg[1] == "3":
            
            #query = "SELECT time_slot.day,time_slot.start_time,course.name,course.credits,classroom.building,classroom.room_number,teacher.name,course.choose,course.course_id FROM takes JOIN section ON section.course_id = takes.course_id JOIN course ON course.course_id = section.course_id JOIN time_slot on time_slot.time_slot_id = section.time_slot_id JOIN classroom on classroom.building = section.building JOIN teaches on teaches.course_id = section.course_id JOIN teacher on teacher.ID = teaches.ID WHERE takes.ID = \"D1101645\" GROUP BY course.course_id;"
            query =  query = f"SELECT day , start_time , course.name , credits , building , room_number , teacher.name , choose , sce_id FROM takes LEFT JOIN section ON section.sec_id = takes.sce_id LEFT JOIN time_slot ON section.time_slot_id = time_slot.time_slot_id LEFT JOIN teaches ON teaches.sec_id = section.sec_id LEFT JOIN teacher ON teacher.ID = teaches.ID LEFT JOIN course ON section.course_id = course.course_id WHERE takes.ID = \"{SIDpass}\";"
            cursor = conn.cursor()
            cursor.execute(query)
            rows = cursor.fetchall()
            results = []

            for row in rows:
                day, start_time, course_name, credits, building, room_number, teacher_name, choose, sce_id = row
                result = {
                    "day": day,
                    "start_time": start_time,
                    "course_name":course_name,
                    "credits": credits,
                    "building": building,
                    "room_number": room_number,
                    "teacher_name": teacher_name,
                    "choose": choose,
                    "sce_id": sce_id
                }
                results.append(result)

            json_data = json.dumps(results,ensure_ascii=False,indent=2)


            line_bot.reply_message(
                event.reply_token,
                TextSendMessage(text=f"已選取課程代碼：{json_data}")
            )   
        elif msg[1] == "4":
            query = f"SELECT  sec_id , name , dept_name , grade , choose , Max_People , current_people , day , start_time ,end_time FROM course LEFT JOIN section ON course.course_id = section.course_id left JOIN time_slot ON section.time_slot_id = time_slot.time_slot_id WHERE NOT EXISTS (SELECT 1 FROM takes WHERE takes.ID = \"{SIDpass}\" AND course.course_id = takes.course_id);"
            cursor = conn.cursor()
            cursor.execute(query)
            rows = cursor.fetchall()
            results = []

            for row in rows:
                sec_id , name , dept_name , grade , choose , Max_People , current_people , day , start_time ,end_time = row
                result = {
                    "sec_id": sec_id,
                    "name": name,
                    "dept_name": dept_name,
                    "grade": grade,
                    "choose": choose,
                    "Max_People": Max_People,
                    "current_people": current_people,
                    "day": day,
                    "start_time": start_time,
                    "end_time": end_time,
                }
                results.append(result)

            json_data = json.dumps(results,ensure_ascii=False,indent=2)

            line_bot.reply_message(
                event.reply_token, 
                TextSendMessage(text=f"可選課程：{json_data}")
            )
        elif msg[1] == "5":
            i = 0
            mode = None
            msg=["",""]
            line_bot.reply_message(
            event.reply_token,
            TextSendMessage(text = "請輸入學號(DXXXXXXX)")
            )
        else:
            line_bot.reply_message(
                event.reply_token, 
                TextSendMessage(text="請輸入數字 1.選課  2.退選  3.查詢課表 4.查詢可選課表 5.退出")
            )

    # 如果已經選擇了模式，根據模式進行處理
    else:
        if mode == "select":
            cursor = conn.cursor()
            # 存取選課代碼
            selected_course_code = msg[1]
            # 存取選課資訊到變數

            selected_courses.append(selected_course_code)

            if msg[1] == "0000":
                line_bot.reply_message(
                    event.reply_token, 
                    TextSendMessage(text=f"已成功選取課程代碼：\n{selected_courses[0:-1]} \n請輸入數字 1.選課 2.退選 3.查看課表 4.查詢「未選」課表")
                )
                selected_courses.pop()
                mode = None
            else:
                student_id = SIDpass

                query=f"SELECT * FROM section s WHERE sec_id = {selected_course_code}"
                cursor = conn.cursor()
                cursor.execute(query)
                sce_code = cursor.fetchone()
                if sce_code == None:
                    line_bot.reply_message(
                        event.reply_token, 
                        TextSendMessage(text=f"查無{selected_course_code}\n請選可選課程：")
                    )
                    selected_courses.pop()
                
                query = f'''SELECT course.grade
                            FROM section
                            INNER JOIN course
                            ON section.course_id = course.course_id
                            WHERE section.sec_id = {selected_course_code}'''
                cursor = conn.cursor()
                cursor.execute(query)
                grade=cursor.fetchone()

                query = f"SELECT total_cred FROM student WHERE ID = '{SIDpass}'"
                cursor = conn.cursor()
                cursor.execute(query)
                selected_credit = cursor.fetchone()
                SUM=int(selected_credit[0]) + int(grade[0])
                if SUM > 30:
                    line_bot.reply_message(
                        event.reply_token,
                        TextSendMessage(text=f"此課程為 {grade[0]} 學分，目前學分總和為  {selected_credit[0]} ，加選後學分已超過最高學分限制(30)！\n請選可選課程：")
                    )
                    selected_courses.pop()

                query = f"SELECT course_id FROM takes WHERE course_id = (SELECT course_id FROM section WHERE sec_id = '{selected_course_code}') AND takes.ID = '{SIDpass}';"
                cursor = conn.cursor()
                cursor.execute(query)
                check_rechoose = cursor.fetchall()

                if len(check_rechoose) != 0:
                    line_bot.reply_message(
                        event.reply_token, 
                        TextSendMessage(text=f"已選過{check_rechoose}\n請選可選課程代碼：")
                    )
                    selected_courses.pop()
                
                query = f'''SELECT takes.sce_id, section.time_slot_id, time_slot.day, time_slot.start_time, time_slot.end_time
                        FROM takes
                        INNER JOIN section
                        ON takes.sce_id = section.sec_id
                        INNER JOIN time_slot
                        ON section.time_slot_id = time_slot.time_slot_id
                        WHERE takes.ID = '{SIDpass}';
                        '''
                cursor = conn.cursor()
                cursor.execute(query)
                check_time = cursor.fetchall()

                query=f'''SELECT section.sec_id, section.time_slot_id, time_slot.day, time_slot.start_time, time_slot.end_time
                        FROM section
                        INNER JOIN time_slot
                        ON time_slot.time_slot_id = section.time_slot_id
                        WHERE section.sec_id = '{selected_course_code}';
                        '''
                cursor = conn.cursor()
                cursor.execute(query)
                choosed_time = cursor.fetchall()
                retime=[]
                # j=0
                # retime=[check_time[j][0],check_time[j][2],check_time[j][3],check_time[j][4]]
                # retime = [choosed_time[0][0],choosed_time[0][1]]
                # line_bot.reply_message(
                #     event.reply_token, 
                #     TextSendMessage(text=f"此{retime} {len(choosed_time)}\n請選可選課程代碼：")
                # )
                for j in range(0,len(check_time)):
                    if choosed_time[0][2] == check_time[j][2] and (choosed_time[0][3] == check_time[j][3] or choosed_time[0][4] == check_time[j][4]):
                        retime=[check_time[j][0],check_time[j][1],check_time[j][2],check_time[j][3],check_time[j][4]]
                        # line_bot.reply_message(
                        #     event.reply_token, 
                        #     TextSendMessage(text=f"此課程時段{choosed_time[0][0]}{choosed_time[0][1]}{check_time[0][3]}衝堂{retime}\n請選可選課程代碼：")
                        # )
                        break

                if len(retime) != 0:
                    line_bot.reply_message(
                        event.reply_token, 
                        TextSendMessage(text=f"此課程{choosed_time[0][0]} {choosed_time[0][2]} {choosed_time[0][3]} {choosed_time[0][4]}衝堂{retime}\n請選可選課程代碼：")
                    )
                    selected_courses.pop()
                query=f'''SELECT current_people,Max_People
                        FROM section
                        WHERE sec_id = '{selected_course_code}';
                        '''
                cursor = conn.cursor()
                cursor.execute(query)
                full_section = cursor.fetchall()
                if full_section[0][0] >= full_section[0][1]:
                    selected_courses.pop()
                    line_bot.reply_message(
                        event.reply_token, 
                        TextSendMessage(text=f"此課程已滿：\n{full_section} \n請選可選課程代碼:")
                    )
                
                else:
                    line_bot.reply_message(
                        event.reply_token, 
                        TextSendMessage(text=f"成功選取課程代碼：\n{selected_courses} \n請輸入選課代碼:")
                    )
                    query = f"SELECT * FROM section WHERE sec_id = {selected_course_code}"
                    cursor = conn.cursor()
                    cursor.execute(query)
                    sec_inform=cursor.fetchone()

                    query = f"INSERT INTO `takes` (`ID`, `course_id`, `sce_id`, `semester`, `year`) VALUES ('{SIDpass}','{sec_inform[0]}','{sec_inform[1]}','{sec_inform[2]}',{sec_inform[3]});"
                    cursor = conn.cursor()
                    cursor.execute(query)
                    conn.commit()

                    query = f"UPDATE section SET current_people = current_people + 1 WHERE sec_id = {selected_course_code};"
                    cursor = conn.cursor()
                    cursor.execute(query)
                    conn.commit()

                    query = f'''SELECT course.grade
                            FROM section
                            INNER JOIN course
                            ON section.course_id = course.course_id
                            WHERE section.sec_id = {selected_course_code}'''
                    cursor = conn.cursor()
                    cursor.execute(query)
                    grade=cursor.fetchone()
                    # intgrade=int(grade[0])

                    query = f"SELECT total_cred FROM student WHERE ID = '{SIDpass}'"
                    cursor = conn.cursor()
                    cursor.execute(query)
                    selected_credit = cursor.fetchone()
                    SUM=int(selected_credit[0]) + int(grade[0])

                    query = f"UPDATE student SET total_cred = {SUM} WHERE ID = '{SIDpass}';"
                    cursor = conn.cursor()
                    cursor.execute(query)
                    conn.commit()
                    
                mode = select
        elif mode == "withdraw":
            # 存取退選課程代碼
            withdrawn_course_code = msg[1]
            # 從選課列表中移除該課程代碼
            query = f"DELETE FROM takes WHERE takes.sce_id = {msg[1]} AND (SELECT SUM(credits) FROM course WHERE course_id IN (SELECT course_id FROM takes WHERE takes.ID = \"{msg[0]}\")) - (SELECT credits FROM course WHERE course_id = (SELECT course_id FROM section WHERE section.sec_id = {msg[1]})) >= 9 AND takes.sce_id IN (SELECT section.sec_id FROM section JOIN course ON section.course_id = course.course_id WHERE takes.id = \"{msg[0]}\" AND course.choose != '必');"
            cursor = conn.cursor()
            cursor.execute(query)
            conn.commit()

            query = f"SELECT course.credits FROM course JOIN section on course.course_id = section.course_id WHERE section.sec_id = {msg[1]}"
            cursor = conn.cursor()
            cursor.execute(query)
            grade=cursor.fetchone()

            line_bot.reply_message(
                event.reply_token, 
                TextSendMessage(text=f"退選成功")
            )
            query = f"UPDATE student SET total_cred = (total_cred - {grade[0]}) WHERE ID = '{SIDpass}';"
            cursor = conn.cursor()
            cursor.execute(query)
            conn.commit()

            query = f"UPDATE section SET section.current_people = current_people - 1 WHERE section.sec_id = '{msg[1]}';"
            cursor = conn.cursor()
            cursor.execute(query)
            conn.commit()

        # 回到模式選擇
        mode = None
        line_bot.reply_message(
            event.reply_token, 
            TextSendMessage(text="請輸入數字 1.選課  2.退選  3.查詢課表 4.查詢可選課表 5.退出")
        )
  
    return "OK"

if __name__ == "__main__":
    app.run("0.0.0.0", port=8080)
