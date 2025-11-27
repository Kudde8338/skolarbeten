import yfinance as yf
from forex_python.converter import CurrencyRates
import json

PORTFOLIOFILE = "portfolios.json"

c = CurrencyRates()

def getPrice(symbol, requestedCurrency=None):
    ticker = yf.Ticker(symbol)
    price = ticker.fast_info["last_price"]
    print(price)
    currency = ticker.fast_info["currency"]
    print(currency)

    if requestedCurrency:
        price = c.convert(currency, requestedCurrency, price)
        currency = requestedCurrency
    
    return [price, currency]

def getDividendsHistory(symbol):
    ticker = yf.Ticker(symbol)
    divs = ticker.dividends
    print(divs)


def loadPortfolios():
    try:
        with open(PORTFOLIOFILE, "r") as f:
            content = f.read().strip()
            if not content:
                return {}
            data = json.load(f)
    except FileNotFoundError:
        data = {}
    return data

def savePortfolios(data):
    with open(PORTFOLIOFILE, "w") as f:
        json.dump(data, f, indent=4)

def createPortfolio(name=None, owner=None, currency=None):
    if name == None:
        name = input("Enter a name for your portfolio: ")
    if owner == None:
        owner = input("Enter the name of the portfolio owner: ")
    if currency == None:
        currency = int(input("Enter the currency you want your portfolio in: "))

    data = loadPortfolios()

    data[name] = {
        "owner": owner,
        "currency": currency,
        "value": 0,
        "stocks": {},
        "bonds": {},
    }

def addStock(name=None, symbol=None, type=none, portfolio=None, date=None, shares=None, price=None):
    if symbol == None:
        symbol = input("Enter the symbol of your stock/bond: ")
    ticker = yf.Ticker(symbol)

    if name == None:
        name = ticker.info.get("shortName")
    
    if type == None:
        type = input("Are you adding a stock or a bond: ")
    if portfolio == None:
        portfolio = input("Enter the name of the portfolio you want the stock in: ")
    if date == None:
        date = input("Enter the date you bought your shares: ")
    if shares == None:
        shares = int(input("Enter the amount of shares you own: "))
    if price == None:
        price = float(input("Enter the price you bought each share for: "))


    data = loadPortfolios()

    if type == "stock":
        data[portfolio]["stocks"][name] = {
            "symbol": symbol,
            "date": date,
            "shares": shares,
            "price": price
        }
    elif type == "bond":
        data[portfolio]["bonds"][name] = {
            "symbol": symbol,

        }

    data[portfolio][type] = {
        
    }

    savePortfolios(data)



getDividendsHistory("ASML")

#createPortfolio()

getPrice("0P00005U1J.ST")