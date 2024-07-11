# TODO: Title block

def read_tsv(filename):
    import pandas as pd
    tsv_df = pd.read_csv(filename, sep='\t', index_col=False, skiprows=[i for i in range(1, 31)], skipfooter=30, engine='python') # Skip first and last data rows (not headers) and last row to avoid formatting issues in .tsv files

    bx1 = tsv_df['/0/vector.x'].to_numpy() # Numpy conversion to avoid pandas dependency throughout
    bx2 = tsv_df['/1/vector.x'].to_numpy()
    bx3 = tsv_df['/2/vector.x'].to_numpy()
    bx4 = tsv_df['/3/vector.x'].to_numpy()

    by1 = tsv_df['/0/vector.y'].to_numpy()
    by2 = tsv_df['/1/vector.y'].to_numpy()
    by3 = tsv_df['/2/vector.y'].to_numpy()
    by4 = tsv_df['/3/vector.y'].to_numpy()

    bz1 = tsv_df['/0/vector.z'].to_numpy()
    bz2 = tsv_df['/1/vector.z'].to_numpy()
    bz3 = tsv_df['/2/vector.z'].to_numpy()
    bz4 = tsv_df['/3/vector.z'].to_numpy()

    x = [bx1, bx2, bx3, bx4]
    y = [by1, by2, by3, by4]
    z = [bz1, bz2, bz3, bz4]

    return x, y, z
