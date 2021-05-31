FROM python:3.6

ENV APPPATH /opt/myflaskapp
COPY . $APPPATH
WORKDIR $APPPATH/app
RUN pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["src/app.py"]
