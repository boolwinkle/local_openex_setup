# Local Openex Setup
This repository provides everything for a quick setup of the Openex platform,
with all the components deployed through docker-compose.

The ```docker-compose.yml``` file provided in this project uses the official Openex 
docker image, along with its dependencies: PostgreSQL and MinIO.

For the mail server, docker-compose runs 
[this](https://github.com/docker-mailserver/docker-mailserver)
production-ready but simple mail server. The project also contains a convenient
bash script for populating the mail server with dummy users. Checking mail has to
be done through a mail client like Thunderbird, with configured incoming and outgoing servers to the docker-mailserver.

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
Copy the ```.env.sample``` file to ```.env``` which will be used by docker-compose:
```
$ cp .env.sample .env
```

Now, in a text editor of your choice, edit the variables marked ```changeMe```.
These are used to access the PostgreSQL database and MinIO. 
You can read more about configuring this part of docker-compose
[here](https://github.com/OpenEx-Platform/docker).


If you must change the 
```MAIL_DOMAIN``` 
variable, make sure to change it in every environment variable where it appears, 
and in ```players_setup.sh```.

## Adding players
This section is optional, you can manually add email addresses to the mailserver using the ```setup.sh```, and players with Openex GUI or API. 
Instructions for mailserver [here](https://github.com/docker-mailserver/docker-mailserver#get-up-and-running).

Edit ```players.txt``` file which the ```players_setup.sh``` will read from. The first line is a comment showing what each column represents. If you want to leave some columns empty, write ```-``` (minus). Each row represents one player. 

Email address which will be used for a player is derived from email, username, or name and surname, in that order of priority. Example: if a player has specified email address, that will be user for their email. If a player doesn't have email address specified, but has username, their email will be ```username@openex.local```, and so on. If specifying email, only put what is in front of ```@openex.local```. Example, if you want a player to have the email ```management@openex.local```, under email you should only put ```management```. 


## Running
To run docker-compose, use the following command:
```
$ sudo docker-compose up -d
```

Before adding players, you will need to login to OpenEx at [```http://localhost:8080```](http://localhost:8080/) (see credentials lower) and navigate to the profile page (upper right corner) and find the API access key. Copy it and paste in ```curl``` in ```players_setup.sh```.

Now, to add the players you specified, run ```bash players_setup.sh```. This will call the ```setup.sh``` script to add players to the mailserver, and OpenEx API to add them to OpenEx.

To the mailserver, you should add the email that OpenEx will use to contact players. The credentials are in ```.env``` variables ```SPRING_MAIL_USERNAME``` and 
```SPRING_MAIL_PASSWORD```, so for example: ```bash setup.sh email add admin@openex.local adminpass```.

### Mail client setup

For convenience, you can edit your ```/etc/hosts``` file and add the line ```127.0.0.1 .openex.local```. This will make it easier for local testing, as Thunderbird will assume this to be the mailserver address.

#### Incoming server
Set the server type to IMAP and listening to the port 143.

#### Outgoing server
Set the server type to SMTP and listening to the port 25.


On both servers, set the security settings to the lowest. This shouldn't be risky on home networks.

Now, if done correctly, you should be able to login to some mail added
to the mail server. To check if everything is working as expected, try to send yourself an email.

###  OpenEx website

Openex will be available at [```http://localhost:8080```](http://localhost:8080/).

Login credentials:
- mail: admin@openex.io
- password: admin

Login credentials can be changed in OpenEx settings.

After logging in for the first time, go to ```http://localhost:8080/admin/profile``` and change the email address to admin@openex.local
