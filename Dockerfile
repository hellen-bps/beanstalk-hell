# 1. Usa uma imagem oficial leve do Python
FROM python:3.11-slim

# 2. Define o diretório de trabalho dentro do container
WORKDIR /app

# 3. Copia primeiro os requisitos para aproveitar o cache de camadas do Docker
COPY requirements.txt .

# 4. Instala as dependências sem salvar cache local (diminui o tamanho da imagem)
RUN pip install --no-cache-dir -r requirements.txt

# 5. Copia o restante do código do projeto (application.py e a pasta templates)
COPY . .

# 6. Informa a porta que o container vai expor (o Beanstalk lê isso)
EXPOSE 5000

# 7. Comando para rodar a aplicação usando o Gunicorn (mais seguro para produção)
# Se quiser usar o servidor nativo do Flask para testes, mude para: CMD ["python", "application.py"]
RUN pip install gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:5000", "application:application"]
