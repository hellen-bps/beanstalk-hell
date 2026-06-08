from flask import Flask, render_template, jsonify
import datetime

# O Beanstalk procura explicitamente pela variável 'application'
application = Flask(__name__)

@application.route('/')
def index():
    return render_template('index.html')

@application.route('/api/status')
def status():
    # Uma rota de API simples para testar requisições dinâmicas
    return jsonify({
        "status": "Online",
        "ambiente": "AWS Elastic Beanstalk",
        "horario_servidor": datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    })

if __name__ == "__main__":
    # O Beanstalk gerencia a porta automaticamente, mas deixar o fallback para 5000 ajuda no teste local
    application.run(host='0.0.0.0', port=5000, debug=True)