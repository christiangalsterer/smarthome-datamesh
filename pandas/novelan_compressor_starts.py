import calendar
import glob
import os
import pandas as pd

def main():
  file_path = '/Users/cg/Documents/Immobilie/Novelan/210124-0F0/*_Text.csv'
  files = glob.glob(file_path)
  compressor_starts_df = pd.DataFrame(columns=['created_date', 'created_at', 'compressor_starts'])

  for file in files:
    df = pd.read_csv(file, sep=';', skiprows=1, names=['0', '1', '2', '3'])
    filename = file.split(os.sep)[-1]
    date = filename.split('_')[0]
    time = filename.split('_')[1]
    year = date[:2]
    month = date[2:4]
    day = date[-2:]
    hour = time[:2]
    minute = time[-2:]
    created_date = f"20{year}-{month}-{day} {hour}:{minute}:59"
    created_date = pd.to_datetime(created_date).tz_localize('Europe/Berlin').tz_convert('UTC')
    created_at = calendar.timegm(created_date.timetuple())

    rows = df[df['0'].str.contains('Impulse Verdichter 1')]
    compressor_starts = rows['1']

    compressor_starts = compressor_starts.iloc[0] if not compressor_starts.empty else None
    if compressor_starts != None:
      compressor_starts_df = compressor_starts_df._append({'created_date': created_date, 'created_at': created_at, 'compressor_starts': compressor_starts}, ignore_index=True)

  if compressor_starts_df.size > 0:
    compressor_starts_df.sort_values(by='created_date', inplace=True)
    compressor_starts_df.to_csv('data/novelan/heatpump/v1/novelan_heatpump_compressor_starts.csv', index=False, sep=';')

if __name__ == "__main__":
  main()