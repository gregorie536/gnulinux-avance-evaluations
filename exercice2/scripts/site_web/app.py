from flask import Flask, request, redirect, url_for, session, render_template_string

app = Flask(__name__)
app.secret_key = 'supersecretkey'  # Nécessaire pour les sessions

# Credentials codés en dur
USERNAME = 'admin'
PASSWORD = 'password123'

# Template HTML pour /login
login_page = '''
<!doctype html>
<title>Login</title>
<h2>Connexion</h2>
<form method="post">
  Nom d'utilisateur : <input type="text" name="username"><br>
  Mot de passe : <input type="password" name="password"><br>
  <input type="submit" value="Se connecter">
</form>
'''

# Template HTML pour /private
private_page = '''
<!doctype html>
<title>Private</title>
<h2>Bienvenue dans l'espace privé !</h2>
<p>Accès autorisé.</p>
<a href="/logout">Se déconnecter</a>
'''

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        if request.form['username'] == USERNAME and request.form['password'] == PASSWORD:
            session['authenticated'] = True
            return redirect(url_for('private'))
        else:
            return "Échec de l'authentification", 401
    return render_template_string(login_page)

@app.route('/private')
def private():
    if not session.get('authenticated'):
        return redirect(url_for('login'))
    return render_template_string(private_page)

@app.route('/logout')
def logout():
    session.pop('authenticated', None)
    return redirect(url_for('login'))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
# Pour exécuter l'application, utilisez la commande suivante dans le terminal :
# FLASK_APP=app.py flask run
# Vous pouvez ensuite accéder à l'application via http://localhost:5000/login
# Assurez-vous d'avoir Flask installé dans votre environnement Python.
# Vous pouvez l'installer avec la commande suivante :
# pip install Flask
# Note : Le mot de passe est codé en dur pour cet exemple. Dans une application réelle, utilisez un système de gestion des utilisateurs sécurisé.

