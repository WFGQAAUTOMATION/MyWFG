__author__ = 'ifayner'
import pyodbc


def convert_the_date(str_date):
    # *** use "strip" method for "Trim" function to eliminate leading and ending spaces ***
    str_date = str(str_date).strip()
    # *** use "in" method for "InStr" to find the char and "index" to find the position to eliminate time ***
    if " " in str_date:
        str_date = str_date[0:str_date.index(" ")]
    day = str_date[8:]
    if day[0] == "0":
        day = day[1:2]
    month = str_date[5:7]
    if month[0] == "0":
        month = month[1:2]
    year = str_date[:4]
    str_date = month + "-" + day + "-" + year
    return str_date


def count_total_notifications():
    result = ""
    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline;Trusted_Connection=True")
    cursor = conn.cursor()
    cursor.execute("SELECT Count(NotificationID) AS NotificationID  FROM wfgLU_Notification")
    rows = cursor.fetchall()
    if rows:
        for row in rows:
            result = row[0]
            print "Result - " + str(result)
    conn.close()
    # conn = None
    return result


def find_lifeline_agent(life_line_id, notification_typeid, state_code):
    agent_code_no = ""
    agent_notification_id = 0
    date_due = "01/01/1900"
    date_due_full = "01/01/1900"
    state = state_code

    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline;Trusted_Connection=True")
    cursor = conn.cursor()
    # LIKE doesn't work in Python, so Texas with Licence# should not be accepted. See WFGLLNotifications table.
    if state_code == "TX" and life_line_id == "4":
        state = ""
    if life_line_id == 1:
        cursor.execute("SELECT Top 1 a.AgentCodeNumber, ll.AgentNotificationID, ll.AgentID,  ll.NotificationID, \
            n.[Description], ll.NotificationSubType, ll.NotificationTypeID, ll.DateDue, ll.Modified, ll.URLEnable \
            FROM [WFGOnline].[dbo].[WFGLLNotifications] ll \
            INNER JOIN [WFGCompass].[dbo].[agAgent]a ON a.AgentID = ll.AgentID \
            INNER JOIN [WFGOnline].[dbo].[wfgLU_Notification] n ON ll.NotificationID= n.NotificationID \
            INNER JOIN [WFGWorkflow].[dbo].[Agent_EandO_Collections] wf ON a.AgentCodeNumber = wf.AgentID \
            INNER JOIN (SELECT DISTINCT AgentID from [WFGCompass].[dbo].[agAgentCycleType] \
            WHERE CycleTypeStatusID = 1 AND EndDate > GETDATE()) c ON a.AgentID = c.AgentID  \
            WHERE ll.NotificationID = ? AND ll.NotificationTypeID = ? \
            ORDER BY AgentNotificationID desc", life_line_id, notification_typeid)
    else:
        if len(state) == 0:
            cursor.execute("SELECT Top 1 a.AgentCodeNumber, ll.AgentNotificationID, ll.AgentID,  ll.NotificationID, \
                n.[Description], ll.NotificationSubType, ll.NotificationTypeID, ll.DateDue, ll.Modified, ll.URLEnable \
                FROM [WFGOnline].[dbo].[WFGLLNotifications] ll \
                INNER JOIN [WFGCompass].[dbo].[agAgent]a ON a.AgentID = ll.AgentID \
                INNER JOIN [WFGOnline].[dbo].[wfgLU_Notification] n ON ll.NotificationID= n.NotificationID \
                INNER JOIN (SELECT DISTINCT AgentID from [WFGCompass].[dbo].[agAgentCycleType] \
                WHERE CycleTypeStatusID = 1 AND EndDate > GETDATE()) c ON a.AgentID = c.AgentID  \
                WHERE ll.NotificationID = ? AND ll.NotificationTypeID = ? \
                ORDER BY AgentNotificationID desc", life_line_id, notification_typeid)
        else:
            state_name = get_state_description(state_code)

            cursor.execute("SELECT Top 1 a.AgentCodeNumber, ll.AgentNotificationID, ll.AgentID,  ll.NotificationID, \
                n.[Description], ll.NotificationSubType, ll.NotificationTypeID, ll.DateDue, ll.Modified, ll.URLEnable \
                FROM [WFGOnline].[dbo].[WFGLLNotifications] ll \
                INNER JOIN [WFGCompass].[dbo].[agAgent]a ON a.AgentID = ll.AgentID \
                INNER JOIN [WFGOnline].[dbo].[wfgLU_Notification] n ON ll.NotificationID= n.NotificationID \
                INNER JOIN (SELECT DISTINCT AgentID from [WFGCompass].[dbo].[agAgentCycleType] \
                WHERE CycleTypeStatusID = 1 AND EndDate > GETDATE()) c ON a.AgentID = c.AgentID \
                WHERE ll.NotificationID = ? AND ll.NotificationTypeID = ? AND ll.NotificationSubType = ?  \
                ORDER BY AgentNotificationID desc", life_line_id, notification_typeid, state_name)

    rows = cursor.fetchall()
    if rows:
        for row in rows:
            agent_code_no = row[0]
            agent_notification_id = row[1]
            if life_line_id != "11" and life_line_id != "12":
                date_due_full = str(row[7])
                date_due = convert_the_date(row[7])
                print date_due
                # # ***** use "strip" method for "Trim" function to eliminate leading and ending spaces*********
                # date_due = str(row[7]).strip()
                # # *** use "in" method for "InStr" to find the char and "index" to find the position to eliminate time
                # if " " in date_due:
                #     date_due = date_due[0:date_due.index(" ")]
                # day = date_due[8:]
                # if day[0] == "0":
                #     day = day[1:2]
                # month = date_due[5:7]
                # if month[0] == "0":
                #     month = month[1:2]
                # year = date_due[:4]
                # date_due = month + "-" + day + "-" + year
    return [agent_code_no, agent_notification_id, date_due, date_due_full]


def get_lifeline_dismiss_notification_agent(life_line_id):
    agent_code_no = ""
    agent_notification_id = 0

    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline;Trusted_Connection=True")
    cursor = conn.cursor()

    cursor.execute("SELECT Top 1 a.AgentCodeNumber, ll.AgentNotificationID, \
         ll.AgentID, Count(a.AgentCodeNumber) as AgentCount  \
         FROM [WFGOnline].[dbo].[WFGLLNotifications] ll \
         INNER JOIN [WFGCompass].[dbo].[agAgent] a ON a.AgentID = ll.AgentID \
         WHERE a.AgentCodeNumber IN (SELECT a.AgentCodeNumber FROM [WFGOnline].[dbo].[WFGLLNotifications] ll \
         INNER JOIN [WFGCompass].[dbo].[agAgent]a  ON a.AgentID=ll.AgentID \
         WHERE ll.NotificationTypeID <> 3) AND ll.NotificationID = ? \
         GROUP BY ll.AgentID, a.AgentCodeNumber, ll.AgentNotificationID \
         ORDER BY COUNT(a.AgentID) desc", life_line_id)
    rows = cursor.fetchall()
    if rows:
        for row in rows:
            agent_code_no = row[0]
            agent_notification_id = row[1]
    return [agent_code_no, agent_notification_id]


def get_lifeline_explanation_agent_id(notification_id):
    agent_code_no = ""
    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline;Trusted_Connection=True")
    cursor = conn.cursor()

    cursor.execute("SELECT Top 1 a.AgentCodeNumber, ll.AgentID, ll.AgentNotificationID, ll.NotificationID \
        FROM [WFGOnline].[dbo].[WFGLLNotifications] ll \
        INNER JOIN [WFGCompass].[dbo].[agAgent]a ON a.AgentID = ll.AgentID \
        INNER JOIN (SELECT DISTINCT AgentID from [WFGCompass].[dbo].[agAgentCycleType] \
        WHERE CycleTypeStatusID = 1 AND EndDate > GETDATE()) c ON a.AgentID = c.AgentID \
        WHERE ll.NotificationID = ? AND ll.NotificationTypeID <> 3 \
        ORDER BY AgentNotificationID desc", notification_id)
    rows = cursor.fetchall()
    if rows:
        for row in rows:
            agent_code_no = row[0]
            print agent_code_no
    return agent_code_no


def get_lifeline_explanation_info(agent_code_no, notif_id, state_code):
    result = ""
    state = ""
    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline;Trusted_Connection=True")
    cursor = conn.cursor()
    if len(state_code) == 0:
        cursor.execute("SELECT ll.* FROM [WFGOnline].[dbo].[WFGLLNotifications] ll \
        INNER JOIN [WFGCompass].[dbo].[agAgent] a  ON a.AgentID = ll.AgentID \
        WHERE a.AgentCodeNumber = ? AND ll.NotificationID = ?", agent_code_no, notif_id)

        rows = cursor.fetchall()
        if rows:
            for row in rows:
                result = row[0]
                print result
    else:
        cursor.execute("SELECT Description FROM [WFGOnline].[dbo].[LU_State_Code] WHERE State_Code = ?", state_code)
        rows = cursor.fetchall()
        for row in rows:
            state = row[0]
            print state

        cursor.execute("SELECT ll.* FROM [WFGOnline].[dbo].[WFGLLNotifications] ll \
        INNER JOIN [WFGCompass].[dbo].[agAgent] a ON a.AgentID = ll.AgentID \
        WHERE a.AgentCodeNumber = ? AND ll.NotificationID = ? AND  \
        ll.NotificationSubType = ?", agent_code_no, notif_id, state)

        rows = cursor.fetchall()
        if rows:
            for row in rows:
                result = row[0]
                print result
    return result


def get_lifeline_link_html_id(agent_code_no, notif_id, state_code):
    result = ""
    state = ""
    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline;Trusted_Connection=True")
    cursor = conn.cursor()
    if len(state_code) == 0:
        cursor.execute("SELECT ll.* FROM [WFGOnline].[dbo].[WFGLLNotifications] ll \
        INNER JOIN [WFGCompass].[dbo].[agAgent] a  ON a.AgentID = ll.AgentID \
        WHERE a.AgentCodeNumber = ? AND ll.NotificationID = ?", agent_code_no, notif_id)

        rows = cursor.fetchall()
        if rows:
            for row in rows:
                result = row[0]
                print result
    else:
        cursor.execute("SELECT Description FROM [WFGOnline].[dbo].[LU_State_Code] WHERE State_Code = ?", state_code)
        rows = cursor.fetchall()
        for row in rows:
            state = row[0]
            print state

        cursor.execute("SELECT ll.* FROM [WFGOnline].[dbo].[WFGLLNotifications] ll \
        INNER JOIN [WFGCompass].[dbo].[agAgent] a ON a.AgentID = ll.AgentID \
        WHERE a.AgentCodeNumber = ? AND ll.NotificationID = ? AND  \
        ll.NotificationSubType = ?", agent_code_no, notif_id, state)

        rows = cursor.fetchall()
        if rows:
            for row in rows:
                result = row[0]
                print result
    return result


def get_lifeline_html_id(agent_code_no, notif_id, notif_type_id, state_code):

    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline;Trusted_Connection=True")
    cursor = conn.cursor()
    if len(state_code) == 0:
        cursor.execute("SELECT Top 1 a.AgentCodeNumber, ll.AgentID, ll.NotificationID, ll.NotificationSubType, \
        ll.NotificationTypeID, ll.DateDue, ll.AgentNotificationID \
        FROM [WFGOnline].[dbo].[WFGLLNotifications] ll  \
        INNER JOIN [WFGCompass].[dbo].[agAgent]a  ON a.AgentID = ll.AgentID \
        INNER JOIN [WFGCompass].[dbo].[agAgentCycleType] c ON a.AgentID = c.AgentID \
        WHERE  a.AgentCodeNumber = ? AND  ll.NotificationID = ? AND ll.NotificationTypeID = ? \
        AND c.CycleTypeStatusID = 1 AND c.EndDate = '01/01/3000'", agent_code_no, notif_id, notif_type_id)
    else:
        cursor.execute("SELECT Top 1 a.AgentCodeNumber, ll.AgentID, ll.NotificationID, ll.NotificationSubType, \
        ll.NotificationTypeID, ll.DateDue, ll.AgentNotificationID \
        FROM [WFGOnline].[dbo].[WFGLLNotifications] ll  \
        INNER JOIN [WFGCompass].[dbo].[agAgent]a  ON a.AgentID = ll.AgentID \
        INNER JOIN [WFGCompass].[dbo].[agAgentCycleType] c ON a.AgentID = c.AgentID \
        WHERE  a.AgentCodeNumber = ? AND  ll.NotificationID = ? \
        AND ll.NotificationTypeID = ? AND ll.NotificationSubType LIKE ? \
        AND c.CycleTypeStatusID = 1 AND c.EndDate = '01/01/3000'", agent_code_no, notif_id, notif_type_id)


def get_lifeline_url(lifeline_id):
    result = ""
    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline;Trusted_Connection=True")
    cursor = conn.cursor()
    cursor.execute("SELECT Count(NotificationID) AS NotificationID FROM wfgLU_Notification")
    rows = cursor.fetchall()
    if rows:
            for row in rows:
                result = row[0]
                print result
    return result


def get_state_description(state_code):
    state = ""
    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline;Trusted_Connection=True")
    cursor = conn.cursor()
    cursor.execute("SELECT Description FROM [WFGOnline].[dbo].[LU_State_Code] WHERE State_Code = ?", state_code)
    rows = cursor.fetchall()
    for row in rows:
        state = row[0]
    return state


def lifeline_green_notifications(icount):
    result = ""
    x = " "

    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline;Trusted_Connection=True")
    cursor = conn.cursor()
    for iparam in range(icount+1):
        cursor.execute("SELECT ll.NotificationID, n.[Description], ll.DateDue, a.AgentCodeNumber,  \
             ll.NotificationSubType, ll.NotificationTypeID, ll.AgentID, ll.Modified \
             FROM [WFGOnline].[dbo].[WFGLLNotifications] ll \
             INNER JOIN [WFGCompass].[dbo].[agAgent] a ON a.AgentID = ll.AgentID \
             INNER JOIN [WFGOnline].[dbo].[wfgLU_Notification] n ON ll.NotificationID= n.NotificationID \
             INNER JOIN (SELECT DISTINCT AgentID FROM [WFGCompass].[dbo].[agAgentCycleType] \
             WHERE CycleTypeStatusID = 1 AND EndDate > GETDATE()) c ON a.AgentID = c.AgentID \
             WHERE ll.NotificationTypeID = 3 AND ll.NotificationID = ? \
             AND DATEDIFF(d, ll.Modified, GETDATE()) > 7 \
             ORDER BY a.AgentCodeNumber, ll.DateDue desc, ll.NotificationSubType", iparam)

        rows = cursor.fetchall()
        if rows:
            for row in rows:
                # [1]-Description, [2]-AgentCodeNo
                lldescr = row[1] + (50 - len(row[1]))*x
                greendate = str(row[2])[:10]
                print iparam, lldescr, greendate, row[3], "Green Line Expired"
        else:
            cursor.execute("SELECT Description FROM wfgLU_Notification WHERE NotificationID = ?", iparam)

            rows = cursor.fetchall()
            if rows:
                for row in rows:
                    print iparam, row[0] + (50 - len(row[0]))*x, "No Life Line Expired Green Notifications found"

    conn.close()
    # conn = None
    return result


def lifeline_old_dates(icount, ll_2, ll_3, ll_9, ll_10):
    result = ""
    x = " "

    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline;Trusted_Connection=True")
    cursor = conn.cursor()
    for iparam in range(icount+1):
        cursor.execute("SELECT ll.NotificationID, n.[Description], ll.DateDue, a.AgentCodeNumber,   \
            ll.NotificationSubType, ll.NotificationTypeID, ll.Modified, ll.AgentID, ll.URLEnable \
            FROM [WFGOnline].[dbo].[WFGLLNotifications] ll \
            INNER JOIN [WFGCompass].[dbo].[agAgent] a ON a.AgentID = ll.AgentID \
            INNER JOIN [WFGOnline].[dbo].[wfgLU_Notification] n ON ll.NotificationID= n.NotificationID \
            INNER JOIN (SELECT DISTINCT AgentID FROM [WFGCompass].[dbo].[agAgentCycleType] \
            WHERE CycleTypeStatusID = 1 AND EndDate > GETDATE()) c ON a.AgentID = c.AgentID \
            WHERE ll.NotificationTypeID <> 3 AND ll.NotificationID = ? \
            AND ll.DateDue <  '01-24-2014' AND ll.NotificationID NOT IN (?,?,?,?) \
            ORDER BY a.AgentCodeNumber, ll.DateDue desc, ll.NotificationSubType", iparam, ll_2, ll_3, ll_9, ll_10)

        rows = cursor.fetchall()
        if rows:
            for row in rows:
                # [0]-NotificationID, [1]-Description, [2]-AgentCodeNo
                lldescr = row[1] + (50 - len(row[1]))*x
                olddate = str(row[2])[:10]
                print iparam, lldescr, olddate, 3*x, row[3]
        else:
            cursor.execute("SELECT Description FROM wfgLU_Notification WHERE NotificationID = ? \
                 AND NotificationID NOT IN (?,?,?,?)", iparam, ll_2, ll_3, ll_9, ll_10)
            rows = cursor.fetchall()
            if rows:
                for row in rows:
                    print iparam, row[0] + (50 - len(row[0]))*x, "No Life Line Old Dates found"

    conn.close()
    # conn = None
    return result


def lifeline_old_dates_archived(icount, ll_2, ll_3, ll_9, ll_10):
    result = ""
    x = " "

    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline;Trusted_Connection=True")
    cursor = conn.cursor()
    for iparam in range(icount+1):
        cursor.execute("SELECT llh.NotificationID, n.[Description], llh.DateDue, a.AgentCodeNumber, llh.AgentID, \
            llh.NotificationSubType, llh.NotificationTypeID, llh.ArchivedDate, llh.IsDismissed, llh.Modified \
            FROM [WFGOnline].[dbo].[WFGLLNotificationsHistory] llh \
            INNER JOIN [WFGCompass].[dbo].[agAgent] a ON a.AgentID = llh.AgentID \
            INNER JOIN [WFGOnline].[dbo].[wfgLU_Notification] n ON n.NotificationID= llh.NotificationID \
            INNER JOIN (SELECT DISTINCT AgentID FROM [WFGCompass].[dbo].[agAgentCycleType] \
            WHERE CycleTypeStatusID = 1 AND EndDate > GETDATE()) c ON a.AgentID = c.AgentID \
            WHERE llh.NotificationTypeID <> 3 AND llh.NotificationID = ? \
            AND llh.DateDue <  '01-24-2014' AND llh.DateDue <  '01-24-2014' AND llh.NotificationID NOT IN (?,?,?,?) \
            ORDER BY a.AgentCodeNumber, llh.Modified desc, llh.NotificationSubType", iparam, ll_2, ll_3, ll_9, ll_10)
        #   ORDER BY a.AgentCodeNumber, llh.Modified desc, llh.NotificationSubType", iparam, ll_archive)

        rows = cursor.fetchall()
        if rows:
            for row in rows:
                # [0]-NotificationID, [1]-Description, [2]-AgentCodeNo
                lldescr = row[1] + (50 - len(row[1]))*x
                archdate = str(row[2])[:10]
                print iparam, lldescr, archdate, 3*x, row[3]
        else:
            cursor.execute("SELECT Description FROM wfgLU_Notification WHERE NotificationID = ? \
                 AND NotificationID NOT IN (?,?,?,?)", iparam, ll_2, ll_3, ll_9, ll_10)
            rows = cursor.fetchall()
            if rows:
                for row in rows:
                    print iparam, row[0] + (50 - len(row[0]))*x, "No Life Line Old Archived Dates found"

    conn.close()
    # conn = None
    return result


def get_archived_datedue(archived_task_html_id):
    result = ""
    x = " "

    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline;Trusted_Connection=True")
    cursor = conn.cursor()

    cursor.execute("SELECT DateDue FROM [WFGOnline].[dbo].[WFGLLNotificationsHistory] \
                   WHERE AgentNotificationID = ?", archived_task_html_id)
    rows = cursor.fetchall()
    if rows:
        for row in rows:
            result = convert_the_date(row[0])
    else:
        print "No Life Line Old Archived Dates found"

    conn.close()
    return result


def lifeline_pcodes(notif_id, p_code1, p_code2, p_code3, p_code4, p_code5, p_code6, p_code7, p_code8, p_comname):
    result = ""
    x = " "

    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline;Trusted_Connection=True")
    cursor = conn.cursor()
    cursor.execute("SELECT ll.NotificationID, n.[Description], ll.DateDue, a.AgentCodeNumber, ll.NotificationSubType, \
        ll.NotificationTypeID, ll.Modified, ll.AgentID \
        FROM [WFGOnline].[dbo].[WFGLLNotifications] ll \
        INNER JOIN [WFGCompass].[dbo].[agAgent] a ON a.AgentID = ll.AgentID \
        INNER JOIN [WFGOnline].[dbo].[wfgLU_Notification] n ON ll.NotificationID= n.NotificationID \
        INNER JOIN (SELECT DISTINCT AgentID FROM [WFGCompass].[dbo].[agAgentCycleType] \
        WHERE CycleTypeStatusID = 1 AND EndDate > GETDATE()) c ON a.AgentID = c.AgentID \
        WHERE ll.NotificationID IN (?) \
        AND LEFT(ll.NotificationSubType, 2) IN (?,?,?,?,?,?,?,?) \
        AND LEFT(ll.NotificationSubType, 3) NOT IN (?) \
        ORDER BY ll.NotificationID,  n.[Description], ll.NotificationSubType, \
        a.AgentCodeNumber", notif_id, p_code1, p_code2, p_code3, p_code4, p_code5, p_code6, p_code7, p_code8, p_comname)

    rows = cursor.fetchall()
    if rows:
        for row in rows:
            # [1]-Description, [2]-AgentCodeNo, [3]-Description
            lldescr = row[1] + (50 - len(row[1]))*x
            pcodedate = str(row[2])[:10]
            print notif_id, lldescr, pcodedate, 3*x, row[3], row[4]
    else:
            cursor.execute("SELECT Description FROM wfgLU_Notification WHERE NotificationID = ?", notif_id)
            rows = cursor.fetchall()
            if rows:
                for row in rows:
                    print notif_id, row[0] + (50 - len(row[0]))*x, "No PCode found"

    conn.close()
    # conn = None
    return result


def lifeline_records_duplications(icount):
    result = ""
    x = " "

    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline;Trusted_Connection=True")
    cursor = conn.cursor()
    for iparam in range(icount+1):
        cursor.execute("SELECT ll.NotificationID, n.[Description], a.AgentCodeNumber, \
            COUNT(a.AgentCodeNumber) AS TasksCount,  ll.NotificationSubType \
            FROM [WFGOnline].[dbo].[WFGLLNotifications] ll \
            INNER JOIN [WFGCompass].[dbo].[agAgent] a ON a.AgentID = ll.AgentID \
            INNER JOIN [WFGOnline].[dbo].[wfgLU_Notification] n ON ll.NotificationID= n.NotificationID \
            INNER JOIN (SELECT DISTINCT AgentID from [WFGCompass].[dbo].[agAgentCycleType] where CycleTypeStatusID = 1 \
            AND EndDate > GETDATE()) c ON a.AgentID = c.AgentID \
            WHERE ll.NotificationTypeID <> 3 AND ll.NotificationID = ? \
            GROUP BY a.AgentCodeNumber, ll.NotificationID, n.Description, ll.NotificationSubType \
            HAVING  COUNT(a.AgentCodeNumber) > 1 \
            ORDER BY a.AgentCodeNumber,  ll.NotificationSubType", iparam)

        rows = cursor.fetchall()
        if rows:
            for row in rows:
                # [0]-NotificationID,[1]-Description, [2]-AgentCodeNo, [3]-## of Notifications
                lldescr = row[1] + (50 - len(row[1]))*x
                print iparam, lldescr, row[3], "duplications found", row[2]
        else:
            cursor.execute("SELECT Description FROM wfgLU_Notification WHERE NotificationID = ?", iparam)

            rows = cursor.fetchall()
            if rows:
                for row in rows:
                    print iparam, row[0] + (50 - len(row[0]))*x, "No Duplication found"

    conn.close()
    # conn = None
    return result


def lifeline_uil_annuity_yellow_notifications(notif_id1, notif_id2):
    result = ""
    x = " "

    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline;Trusted_Connection=True")
    cursor = conn.cursor()

    cursor.execute("SELECT NotificationID, Description FROM wfgLU_Notification \
                    WHERE NotificationID IN (?, ?)", notif_id1, notif_id2)
    rows = cursor.fetchall()
    for row1 in rows:
        cursor.execute("SELECT ll.NotificationID, n.[Description], ll.DateDue, a.AgentCodeNumber, ll.NotificationSubType, \
            ll.NotificationTypeID, ll.Modified, ll.AgentID \
            FROM [WFGOnline].[dbo].[WFGLLNotifications] ll \
            INNER JOIN [WFGCompass].[dbo].[agAgent] a ON a.AgentID = ll.AgentID \
            INNER JOIN [WFGOnline].[dbo].[wfgLU_Notification] n ON ll.NotificationID= n.NotificationID \
            INNER JOIN (SELECT DISTINCT AgentID FROM [WFGCompass].[dbo].[agAgentCycleType] \
            WHERE CycleTypeStatusID = 1 AND EndDate > GETDATE()) c ON a.AgentID = c.AgentID \
            WHERE ll.NotificationTypeID = 2 AND ll.NotificationID = ? \
            ORDER BY ll.NotificationID, a.AgentCodeNumber", row1[0])

        rows = cursor.fetchall()
        if rows:
            for row in rows:
                # [1]-Description, [2]-AgentCodeNo, [3]-Description
                lldescr = row[1] + (30 - len(row[1]))*x
                print row[0], lldescr, row[3]
        else:
            print row1[0], row1[1] + (30 - len(row1[1]))*x, "No Yellow Notifications found"

    conn.close()
    # conn = None
    return result


def select_agent_id_info(agent_id1, agent_id2):
    result = ""
    print "First agent - " + agent_id1
    print "Second agent - " + agent_id2
    # conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline;UID=;PWD=")
    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGCompass;Trusted_Connection=True")
    cursor = conn.cursor()
    cursor.execute("SELECT AgentCodeNumber,FirstName,LastName FROM agAgent WHERE AgentID IN(?,?)", agent_id1, agent_id2)
    rows = cursor.fetchall()
    if rows:
        for row in rows:
            print "Row " + str(row)
            result = row[0], row[1], row[2]
            print "Result - " + str(result)
    conn.close()
    # conn = None
    return result


def select_agent_id(agent_id):
    result = ""
    print "Selected agent - " + agent_id
    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGCompass;Trusted_Connection=True")
    cursor = conn.cursor()
    cursor.execute("SELECT AgentCodeNumber,FirstName,LastName FROM agAgent WHERE AgentID = ?", agent_id)
    rows = cursor.fetchall()
    if rows:
        for row in rows:
            result = row[0]
            print "Result - " + str(result)
    conn.close()
    # conn = None
    return result


def find_excel_data(var_Name):
    result = ""
    # conn = pyodbc.connect("Driver={Microsoft Excel Driver (*.xls, *.xlsx, *.xlsm, *.xlsb)}; \
    #                         DBQ=C:\Get_Robot_Variables\RobotFramework.xls;ReadOnly=0", autocommit=True)
    conn = pyodbc.connect("Driver={Microsoft Excel Driver (*.xls, *.xlsx, *.xlsm, *.xlsb)}; \
                          DBQ=C:\Get_Robot_Variables\RobotFramework.xls;ReadOnly=0", autocommit=True)
    cursor = conn.cursor()
    # for tab in cursor.tables():
    #     print tab
    cursor.execute("SELECT var_Value FROM [MyWFGData$] WHERE var_Name = ?", var_Name)
    rows = cursor.fetchall()
    if rows:
        for row in rows:
            result = row[0]
    conn.close()
    return result
