# ce ficher doit être joué dans Cloud Build (chemins relatifs partant de la racine du repo)
DEPython : 3.12.1

# permet de streamer les logs du conteneur sur des plateformes KNative
ENV PYTHONUNBUFFERED Vrai

RÉP TRAVAIL /usr/src/app

COPIER ./requirements.txt ./

EXÉCUTER pip install --upgrade pip
EXÉCUTER pip install --no-cache-dir -r conditions.txt

COPIE . .

# cette fois-ci on compile l'application en mode production
ENV FLASK_APP=app.py  
ENV FLASK_ENV=production

# permet de constater que l'on est bien dans le Dockerfile de prod
RUN echo "HEY IM THE PROD DOCKERFILE"

# serveur de production;
# 8 threads par travailleur, 1 travailleur par CPU, 0 secondes de timeout pour permettre à Cloud Run de gérer le scaling
CMD exec gunicorn --bind :5000 --workers 1 --threads 8 --timeout 0 'app:create_app()'