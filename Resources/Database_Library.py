__author__ = 'ifayner'

import pyodbc


def select_agent_id_info(agent_id1, agent_id2):
    result = ""
    print "First agent - " + agent_id1
    print "Second agent - " + agent_id2
    # conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline;UID=;PWD=")
    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGCompass")
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
    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGCompass")
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


def count_total_notifications():
    result = ""
    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline")
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


def get_lifeline_agent_id(notification_id, notification_typeid, state_code):
    agent_code_no = ""
    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline")
    cursor = conn.cursor()

    if len(state_code) == 0:
        cursor.execute("SELECT Top 1 a.AgentCodeNumber, ll.AgentID, ll.AgentNotificationID, ll.NotificationID, \
            n.[Description], ll.NotificationSubType, ll.NotificationTypeID, ll.DateDue, ll.Modified, ll.URLEnable \
            FROM [WFGOnline].[dbo].[WFGLLNotifications] ll \
            INNER JOIN [WFGCompass].[dbo].[agAgent]a ON a.AgentID = ll.AgentID \
            INNER JOIN [WFGOnline].[dbo].[wfgLU_Notification] n ON ll.NotificationID= n.NotificationID \
            INNER JOIN (SELECT DISTINCT AgentID from [WFGCompass].[dbo].[agAgentCycleType] \
            WHERE CycleTypeStatusID = 1 AND EndDate > GETDATE()) c \
            ON a.AgentID = c.AgentID WHERE ll.NotificationID = ? AND ll.NotificationTypeID = ? \
            ORDER BY AgentNotificationID desc", notification_id, notification_typeid)
    else:
        state = get_state_description(state_code)

        cursor.execute("SELECT Top 1 a.AgentCodeNumber, ll.AgentID, ll.AgentNotificationID, ll.NotificationID, \
            n.[Description], ll.NotificationSubType, ll.NotificationTypeID, ll.DateDue, ll.Modified, ll.URLEnable \
            FROM [WFGOnline].[dbo].[WFGLLNotifications] ll \
            INNER JOIN [WFGCompass].[dbo].[agAgent]a ON a.AgentID = ll.AgentID \
            INNER JOIN [WFGOnline].[dbo].[wfgLU_Notification] n ON ll.NotificationID= n.NotificationID \
            INNER JOIN (SELECT DISTINCT AgentID from [WFGCompass].[dbo].[agAgentCycleType] \
            WHERE CycleTypeStatusID = 1 AND EndDate > GETDATE()) c ON a.AgentID = c.AgentID \
            WHERE ll.NotificationID = ? AND ll.NotificationTypeID = ? AND ll.NotificationSubType LIKE ? \
            ORDER BY AgentNotificationID desc", notification_id, notification_typeid, state)

    rows = cursor.fetchall()
    if rows:
        for row in rows:
            agent_code_no = row[0]
            print agent_code_no
    return agent_code_no


def get_lifeline_explanation_agent_id(notification_id):
    agent_code_no = ""
    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline")
    cursor = conn.cursor()

    cursor.execute("SELECT Top 1 a.AgentCodeNumber, ll.AgentID, ll.AgentNotificationID, ll.NotificationID \
        FROM [WFGOnline].[dbo].[WFGLLNotifications] ll \
        INNER JOIN [WFGCompass].[dbo].[agAgent]a ON a.AgentID = ll.AgentID \
        INNER JOIN (SELECT DISTINCT AgentID from [WFGCompass].[dbo].[agAgentCycleType] \
        WHERE CycleTypeStatusID = 1 AND EndDate > GETDATE()) c ON a.AgentID = c.AgentID WHERE ll.NotificationID = ? \
        ORDER BY AgentNotificationID desc", notification_id)
    rows = cursor.fetchall()
    if rows:
        for row in rows:
            agent_code_no = row[0]
            print agent_code_no
    return agent_code_no


def lifeline_records_duplications(icount):
    result = ""
    x = " "

    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline")
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


def lifeline_old_dates(icount, ll_2, ll_3, ll_9, ll_10):
    result = ""
    x = " "

    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline")
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

    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline")
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


def lifeline_pcodes(notif_id, p_code1, p_code2, p_code3, p_code4, p_code5, p_code6, p_code7, p_code8, p_comname):
    result = ""
    x = " "

    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline")
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


def lifeline_green_notifications(icount):
    result = ""
    x = " "

    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline")
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


def lifeline_uil_annuity_yellow_notifications(notif_id1, notif_id2):
    result = ""
    x = " "

    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline")
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


def get_lifeline_explanation_info(agent_code_no, notif_id, state_code):
    result = ""
    state = ""
    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline")
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


def get_state_description(state_code):
    state = ""
    conn = pyodbc.connect("DRIVER={SQL Server};SERVER=CRDBCOMP03\CRDBWFGOMOD;DATABASE=WFGOnline")
    cursor = conn.cursor()
    cursor.execute("SELECT Description FROM [WFGOnline].[dbo].[LU_State_Code] WHERE State_Code = ?", state_code)
    rows = cursor.fetchall()
    for row in rows:
        state = row[0]
    return state
