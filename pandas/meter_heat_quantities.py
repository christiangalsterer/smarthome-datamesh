import glob
import matplotlib.pyplot as plt
import pandas as pd

def read_meter_heat_quantities(file_path) -> pd.DataFrame:
    # Read the CSV file into a DataFrame
    files = glob.glob(file_path)
    df = pd.concat([pd.read_csv(f, parse_dates=True, date_format={'created_date': '%Y-%m-%d %H:%M:%S'}, sep=';', index_col='created_date') for f in files])
    df = df.resample("ME").max()
    df['monthly_difference'] = df['heat_quantity'].diff(periods=1)
    write_meter_heat_quantities(df)
    return df

def write_meter_heat_quantities(df):
    df.to_csv('data/engelmann/sensostar/v1/heat_quantity_meter_monthly.csv', index=True)
def plot(df):
    df['monthly_difference'].plot(kind='line', title='Heat Quantity Over Time', legend=True)
    plt.xlabel('Date')
    plt.ylabel('Heat Quantity')
    plt.show()

def main():
    file_path = 'data/engelmann/sensostar/v1/heat_quantity_meter_2*.csv'
    meter_heat_quantities_df = read_meter_heat_quantities(file_path)
    print(meter_heat_quantities_df)
    plot(meter_heat_quantities_df)

if __name__ == "__main__":
  main()