Console Unfuddle
================

Utilite for work with unfuddle.com account from console

1. gem install confuddle
2. Edit HOME_DIR/.passwd_to_unfuddle.yml and fill with your own values
3. $ un projects
and set for each project aliases "un alias"
and set current project "un curr"

Tasks:
    un addcm NUMBER                       # add ticket comment
    un addt NUMBER HOURS COMMENT [DATE]   # add time
    un alias PROJECT_ID ALIAS             # set project alias
    un all [REGEXP]                       # show all tickets for current project
    un alla [REGEXP]                      # show all (in all projects) tickets
    un assi TICKETS [NEW_ASSIGNEE]        # update tickets assingee
    un at PERIOD                          # show all times report for account (PERIOD = [tm lm tw lw y [0-9]+])
    un atm PERIOD                         # show my times report for account (PERIOD = [tm lm tw lw y [0-9]+])
    un clear                              # clear caches
    un curr ID_OR_ALIAS                   # set current project id
    un help [TASK]                        # Describe available tasks or one specific task
    un my                                 # show tickets assignee to me for current project
    un mya                                # show tickets (in all projects) assignee to me
    un new ALIAS TITLE [ASSIGNEE] [PRIO]  # create ticket
    un notify PARAMS                      # Notify about changes with tickets by Gnome-Notify, PARAMS='status,comments'
    un op TICKET_ID                       # Open selected ticked from current project in browser
    un projects                           # show all projects for your account
    un show NUMBER [t]                    # show ticket by number, [t] - show TimeEntries
    un t PERIOD                           # show all times report (PERIOD = [tm lm tw lw y [0-9]+])
    un tm PERIOD                          # show my times report (PERIOD = [tm lm tw lw y [0-9]+])
    un upd TICKETS NEW_STATUS             # update tickets statuses

Used gems:
    unfuzzle by Patrick Reagan of Viget Labs
    grapt by Patrick Reagan
