import yfinance as yf
from forex_python.converter import CurrencyRates

c = CurrencyRates()

def getPrice(symbol, requestedCurrency=None):
    ticker = yf.Ticker(symbol)
    price = ticker.fast_info["last_price"]
    currency = ticker.fast_info["currency"]

    if requestedCurrency:
        price = c.convert(currency, requestedCurrency, price)
        currency = requestedCurrency
    
    return [round(price, 2), currency]

QCOM = getPrice("QCOM", "SEK")
SHBB = getPrice("SHB-B.ST", "SEK")
FRACTL = getPrice("FRACTL.ST", "SEK")
MTGB = getPrice("MTG-B.ST", "SEK")
AVANZAZERO = getPrice("0P00005U1J.ST", "SEK")

QCOM_shares = 1
SHBB_shares = 30
FRACTL_shares = 5
MTGB_shares = 5
AVANZAZERO_shares = 14.21

QCOM_value = round(QCOM[0] * QCOM_shares, 2)
SHBB_value = round(SHBB[0] * SHBB_shares, 2)
FRACTL_value = round(FRACTL[0] * FRACTL_shares, 2)
MTGB_value = round(MTGB[0] * MTGB_shares, 2)
AVANZAZERO_value = round(AVANZAZERO[0] * AVANZAZERO_shares, 2)

print("==== Current Values ====")
print("Qualcomm: " + str(QCOM[0]) + " SEK")
print("Handelsbanken: " + str(SHBB[0]) + " SEK")
print("FRACTAL: " + str(FRACTL[0]) + " SEK")
print("MTG B: " + str(MTGB[0]) + " SEK")
print("AVANZA ZERO: " + str(AVANZAZERO[0]) + " SEK")

print("")

print("==== Owned Value ====")
print("Qualcomm: " + str(QCOM_value) + " SEK")
print("Handelsbanken: " + str(SHBB_value) + " SEK")
print("FRACTAL: " + str(FRACTL_value) + " SEK")
print("MTG B: " + str(MTGB_value) + " SEK")
print("AVANZA AERO: " + str(AVANZAZERO_value) + " SEK")

print("")

print("==== General Data ====")
print("Total value: " + str(QCOM_value + SHBB_value + FRACTL_value + MTGB_value + AVANZAZERO_value) + " SEK")
