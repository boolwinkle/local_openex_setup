
# Local Openex Setup
This repository provides everything for a quick setup of the Openex platform,
with all the components deployed trough docker-compose.

The ```docker-compose.yml``` file provided in this project uses the official Openex 
docker image, along with its dependencies: PostgreSQL and MinIO.

For the mail server, docker-compose runs 
[this](https://github.com/docker-mailserver/docker-mailserver)
production-ready but simple mail server. The project also contains a convenient
bash script for populating the mail server with dummy users. Checking mails has to
be done trough a mail client like ThunderBird, with configured incoming and outgoing
server to the docker-mailserver.

## Pre-requisites
You will need to install docker-compose for your operating system.
You can learn more about the installation 
[here](https://docs.docker.com/compose/install).

## Clone the repository
```
$ git clone https://github.com/boolwinkle/local_openex_setup.git
$ cd local_openex_setup
```

## Configuring the environment variables
Copy the ```.env.sample``` file to ```.env``` which the docker-compose will use:
```
$ cp .env.sample .env
```

Now, in a text editor of your choice, edit the variables marked ```changeMe```.
These are used to access the PostgreSQL database and MinIO. 
About configuring this part of docker-compose you can read
[here](https://github.com/OpenEx-Platform/docker).

If you must change the 
```MAIL_DOMAIN``` 
variable, make sure to change it in every environment variable where it appears, 
and in ```populate_mailserver.sh```.

## Adding dummy players
This section is optional, you can manually add players with the ```setup.sh```. 
Instructions [here](https://github.com/docker-mailserver/docker-mailserver#get-up-and-running).

Copy the ```sample_players.txt``` to ```players.txt``` which the 
```populate_mailserver.sh``` will read.
```
$ cp sample_players.txt players.txt
```

Now, in a text editor of your choice, add to ```players.txt``` lines with space 
separated values for username and mail password. The bash script will add
```@openex.local``` to the username, so for example, if you want to add 
```matko@openex.local``` to the mail server, to ```players.txt``` you should append
```matko some_password```.

Feel free to overwrite any line
except for the first one, ```admin adminpass```. That one is used by the Openex
Platform to log into the mail server.

Now, when you run docker-compose, you will be able to populate it with mails,
using the ```populate_mailserver.sh``` script.

### Mail client setup
#### Incoming server
Set the server type to IMAP and listening to the port 143.
Set the server name/adress to localhost.

#### Outgoing server
Set the server type to SMTP and listening to the port 25.
Set the server name/adress to localhost.


In both servers, set the security settings to the lowest. This shouldn't be risky on home
networks.


## Running
To run docker-compose, use the following command:
```
$ sudo docker-compose up -d
```
If you're runnnig the mail server for the first time, you must add at least one
mail to the mail server. Do so by running:
```$ bash populate_mailserver.sh```, or add some manually. More detailed instructions
can be found
[here](https://github.com/docker-mailserver/docker-mailserver#starting-for-the-first-time).

Now, if done correctly, you should be able to login to some mail added
to the mail server. To check if everything is working as expected, try to send yourself
a mail.

Openex will now be available at [```http://localhost:8080```](http://localhost:8080/).

Login credentials:
 - mail: admin@openex.io
 - password: admin

 You can now add players with addresses from the mailserver. 
