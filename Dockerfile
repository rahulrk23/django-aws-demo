FROM python:3.8-slim

RUN useradd -r -s /bin/bash rahul

ENV HOME /app
WORKDIR /app
ENV PATH="/app/.local/bin:${PATH}"

RUN chown -R rahul:rahul /app
USER rahul

ENV DEBUG=True
ENV ENV_TYPE='production'

ARG AWS_ACCESS_KEY_ID
ARG AWS_SECRET_ACCESS_KEY
ARG AWS_DEFAULT_REGION

ENV AWS_ACCESS_KEY_ID $AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY $AWS_SECRET_ACCESS_KEY
ENV AWS_DEFAULT_REGION $AWS_DEFAULT_REGION

ADD ./requirements.txt ./requirements.txt
RUN pip install --no-cache-dir -r ./requirements.txt --user

COPY . /app
WORKDIR /app

# CMD ["gunicorn", "-b", "0.0.0.0:8000", "app:app", "--workers=5"]
CMD python manage.py runserver 0.0.0.0:8000