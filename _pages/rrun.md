---
title: rRun
subtitle: Lightweight bash based application launcher
includes: [lightbox]
---

On my primary machine I run Debian GNU/Linux. Several times over the last few years I have looked for a stand alone application launcher. There are several available, however each time I've used them I have missed features of bash which enable me to be more productive. In particular I missed advanced completion and reverse history search.

The table below lists some of the characteristics present in bash that I would hope to see in a launcher. There were several launchers that were frequently recommend on websites, for each of these there is a column indicating if it correctly performs the completion. In addition rRun is included. Bold indicates the portion bash would complete.

| Valid Completions                   | Example                      | gexec | gmrun | grun | xfce4-appfinder | rRun |
| ----------------------------------- | ---------------------------- | ----- | ----- | ---- | --------------- | ---- |
| Executable                          | gee**qie**                   | Y     | Y     | Y    | Y               | Y    |
| Absolute path                       | geeqie /h**ome**             | Y     | Y     | N    | N               | Y    |
| Relative path                       | geeqie p**hotos**            | N     | N     | N    | N               | Y    |
| Executable for sudo command         | sudo gee**qie**              | Y     | Y     | N    | N               | Y    |
| sbin executable for sudo command    | sudo mkfs.v**fat**           | N     | N     | N    | N               | Y    |
| Non-file argument                   | aptitude sh**ow** geeq**ie** | N     | N     | N    | N               | Y    |
| Ability to display multiple options | g                            | N     | Y     | N    | Y               | Y    |

Launchers that can complete commands and arguments are susceptible to completing invalid terms. The table below shows if the launcher correctly suppresses the completion (i.e. 'Y' is good 'N' is bad). Bold indicates the invalid portion completed. 

| Invalid Completions                  | Example           | gexec | gmrun | rRun |
| ------------------------------------ | ----------------- | ----- | ----- | ---- |
| Executable where file needed         | geeqie gee**qie** | N     | N     | Y    |
| File where executable neede          | /etc/hostn**ame** | N     | N     | Y    |
| File argument when file is not valid | kill /mn**t**     | N     | N     | Y    |

| Non-Completion Features          | gexec              | gmrun | grun | xfce4-appfinder | rRun |
| -------------------------------- | ------------------ | ----- | ---- | --------------- | ---- |
| Execute sudo command             | Y (with check box) | N     | N    | N               | Y    |
| Repeat last command from history | Y                  | Y     | Y    | N               | Y    |
| Reverse history search           | N                  | N     | N    | N               | Y    |

In addition bash has some other features which occasionally come in handy in a launcher:

*   Complex history substitution
*   Pipelines and redirection
*   Inline scripts
*   Aliases
*   User defined functions

It seemed to me that the tool I was looking for had to be built on bash. For a while I simply used an x-terminal-emulator to launch applications, however there were several characteristics I didn't like about this approach:

*   While applications are running the screen will be cluttered by x-terminal-emulator windows 
*   Once an application has closed, the associated x-terminal-window will need to be manually closed 
*   The statement will only be added to the history once completed 

The solution I developed preforms all of the completions correctly and overcomes the problems of just using an x-terminal-emulator. It uses a normal x-terminal-emulator window running an interactive bash shell.

1.  The user enters a script (or simple command) 
    *   they can use any normal bash features including 
        *   all history features
        *   advanced tab completion
        *   multi-line script entry, etc
    *   the window shows multiple lines so tab completion options are easy to view
2.  The user hits enter 
    *   the command is started
    *   the x-terminal-emulator window disappears (is not present on screen, task bar, pager etc)
    *   the command is immediately added to the history 
        *   if it meets the user's normal requirements to be added to the history
        *   if a ~/.rrun_history file is present it will be used, otherwise the users default bash history file will be used
3.  As the script runs, if it uses sudo and a password is required, an ssh-askpass GUI will be displayed to allow the password to be entered

In addition to the basic launcher functionality rRun supports display of the console output. Consider for example a program started using a launcher stops responding or crashes, it would be handy to be able to see the console. rRun windows remain available for 1 minute after the application exits. The command line tool `rrunctl` can be used to display or hide rRun launcher windows. I have shortcuts configured for interacting with rRun:

| Key Combination   | Command                 | Description                                                                                                                                                    |
| ----------------- | ----------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `Super + r`       | `rrun`                  | Launch a new rRun window ready to enter a new script (command)                                                                                                 |
| `Super + b`       | `rrunctl toggle`        | Toggle visibility of the rRun window (if the active window was launched by rRun, display the associated rRun, if the current window is an rRun window hide it) |
| `Super + Alt + r` | `rrunctl showcompleted` | Show all rRun windows for recently completed scripts                                                                                                           |

## Screenshots

{% lightbox --group "screenshots" --alt "Screenshot of rrun showing tab completion" --title "Tab completion works like normal" /images/rrun-screenshots/rRunMultipleOptions.png %}
{% lightbox --group "screenshots" --alt "Screenshot of rrun while a command is executing" --title "When executing, command output is shown in the console" /images/rrun-screenshots/rRunRunningACommand.png %}
{% lightbox --group="screenshots" --alt "Screenshot of rrun after the command has completed" --title "After the command has completed, the command output is still visible" /images/rrun-screenshots/rRunAfterCommandCompleted.png %}

## Download

rRun is released under the GPL3 license, the source code is available on [GitHub](https://github.com/reubenpeeris/rrun).

