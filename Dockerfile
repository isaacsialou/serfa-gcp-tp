# on récupère depuis Dockerhub une image de base de Python
# IMAGE:TAG => le tag est l'identifiant unique de la version de l'image
FROM python:3.12.1

RUN apt install -y curl

#  docker build -t hello-world .
# cette commande veut dire "construis cette image Docker";
# le `-t` signifie "tag", c'est à dire le nom de votre image;
# le `.` à la fin signifie "dans le dossier courant"

# pour exécuter un terminal dans notre running container =>
# 1) run le container avec un programme => docker run -it hello-world PROGRAMME
# 2) exécuter un terminal bash dans le container => docker exec -it hello-world bash

# on `run` des images et on `exec` des containers

# ici on récupère les dépendances de notre projet,
# en les copiant dans le dossier courant
WORKDIR /usr/src/app
COPY ./requirements.txt .

# on installe les dépendances
RUN pip install -r requirements.txt

# on va copier le code de l'applicatreion
COPY ./app.py .

# on met en place les variables d'environnement pour le debug
ENV FLASK_ENV=development
ENV FLASK_APP=app.py   

# `CMD` signifie "lance cette commande quand le container est lancé"
# `sh -c` => "j'ouvre une shell et je lui passe la commande suivante"
CMD ["sh", "-c", "flask run --host=0.0.0.0"]