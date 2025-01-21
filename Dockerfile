FROM python:3.12.8

RUN pip install pandas psycopg2 
ENTRYPOINT ["bash"]