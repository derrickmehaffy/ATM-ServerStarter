# Useful commands for the Linux Screen command

## Running the startserver.sh script

```bash
screen -dmS atm ./startserver.sh
```

Flags:

* `-d` - Detach from the screen session
* `-m` - Create a new screen session
* `-S` - Name the screen session

## Sending Minecraft commands to the named session

```bash
screen -S sessionName -p 0 -X stuff 'say test\n'
```

- Replace session name with the name of the screen session you created.
- Replace the `say test` with the command you want to send to the server. Note that you will need to include the `\n` to force the command to be executed. (Newline character)

## Cronjob examples

### Restart the server every 8 hours with 3 warnings

```bash
0 */8 * * * screen -S atm8 -p 0 -X stuff 'say Server Restarting in 15 Minutes\n'
15 */8 * * * screen -S atm8 -p 0 -X stuff 'say Server Restarting in 10 Minutes\n'
25 */8 * * * screen -S atm8 -p 0 -X stuff 'say Server Restarting in 5 Minutes\n'
30 */8 * * * screen -S atm8 -p 0 -X stuff 'say Server Restarting Now! It will be back in about 2 minutes!\n'
31 */8 * * * screen -S atm8 -p 0 -X stuff 'stop\n'
```

This will send 3 warnings and restart the server 31 minutes after the 8th hour mark. (00:31, 08:31, 16:31)

On Ubuntu/Debian based distros you can use `crontab -e` to edit the crontab file.