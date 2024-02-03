FROM python:3.9-slim

# Establish a working folder
WORKDIR /app

# Establish dependencies pip install --user -r requirements.txt COPY requirements.txt .

RUN python -m pip install -U pip wheel && \
    
    pip install Werkzeug==2.1.2 && \
    pip install Flask==2.1.2 && \
    pip install python-dotenv==0.20.0 && \
    pip install gunicorn==20.1.0 && \
    pip install honcho==1.1.0 && \
    pip install pylint==2.14.0 && \
    pip install flake8==4.0.1 && \
    pip install black==22.3.0 && \
    pip install nose==1.3.7 && \
    pip install pinocchio==0.4.3 && \
    pip install coverage==6.3.2 && \
    pip install httpie==3.2.1

# Copy source files last because they change the most
COPY service ./service

# Become non-root user
RUN useradd -m -r service && \
    chown -R service:service /app
USER service

# Run the service on port 8000
ENV PORT 8000
EXPOSE $PORT
CMD ["gunicorn", "service:app", "--bind", "0.0.0.0:8000"]
