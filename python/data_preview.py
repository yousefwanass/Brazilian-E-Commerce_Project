import pandas as pd
from sqlalchemy import create_engine
import urllib
from pathlib import Path

# =====================================
# SQL Server Connection
# =====================================

server = r"localhost\SQLEXPRESS"
database = "Brazilian E_Commerce"

connection_string = urllib.parse.quote_plus(
    f"DRIVER={{ODBC Driver 17 for SQL Server}};"
    f"SERVER={server};"
    f"DATABASE={database};"
    "Trusted_Connection=yes;"
)

engine = create_engine(
    f"mssql+pyodbc:///?odbc_connect={connection_string}"
)

# =====================================
# Read SQL Query
# =====================================

sql_file = (
    Path(__file__).resolve().parent.parent
    / "SQL"
    / "reports"
    / "Executive_dashboard_dataset.sql"
)

print("=" * 50)
print("SQL File:")
print(sql_file)
print("=" * 50)

if not sql_file.exists():
    raise FileNotFoundError(f"SQL file not found:\n{sql_file}")

with open(sql_file, "r", encoding="utf-8") as file:
    query = file.read()

# =====================================
# Execute SQL Query
# =====================================

print("Connecting to SQL Server...")

df = pd.read_sql(query, engine)

print("Connected Successfully!")

# =====================================
# Data Preview
# =====================================

print("\nFirst 5 Rows:")
print(df.head())

print("\nDataset Shape:")
print(df.shape)

print("\nColumns:")
print(df.columns.tolist())

print("\nData Types:")
print(df.dtypes)

print("\nMissing Values:")
print(df.isnull().sum())

print("\nSummary Statistics:")
print(df.describe(include="all"))