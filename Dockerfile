FROM python:3.9-slim

RUN mkdir -p /app && \
    addgroup --quiet --system --gid 1000 app && \
    adduser --quiet --system --home /app --uid 1000 --group app --disabled-password  && \
    chown -R app:app /app
WORKDIR /app
RUN pip install --no-cache-dir pipenv

# Install Pipfile dependencies
COPY --chown=app:app Pipfile* /app/
RUN pipenv install --deploy --system

COPY --chown=app:app foo/ /app/foo

USER app

EXPOSE 80

CMD [ "uvicorn", "foo.main:app", "--host", "0.0.0.0", "--port", "80" ] 
