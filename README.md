
# Flutter finance

This app allows users to track a company's estimated vs. actual earnings over time, visualized through an interactive bar chart. Users can view detailed earnings data by hovering over chart bars and access earnings call transcripts for specific periods.


## API Reference

#### Get all earningscalendar

```http
  GET /api//v1/earningscalendar
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `ticker` | `string` | Company ticker symbol (e.g., MSFT). |

#### Get 

```http
  GET /api//v1/earningstranscript 
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `ticker`      | `string` | Company ticker symbol (e.g., AAPL)|
| `year`      | `string` | Earnings year (e.g., 2024).|
| `quarter`      | `string` | Earnings quarter from Q1 to Q4. Must be one of the following values: 1, 2, 3, 4.|

## Screenshots

![App Screenshot](https://drive.google.com/file/d/1E91Nv7cXE_BiQ7_P83rL5Cx4CKIapwaS/view?usp=sharing)

![App Screenshot](https://drive.google.com/file/d/1x2d8hAB8HqjpwqDvGYlFsjqRM_R-txPX/view?usp=sharing)

![App Screenshot](https://drive.google.com/file/d/1RkKVqSJt3JADFg6lsuhwsS3FmQTO-1Wk/view?usp=sharing)

![App Screenshot](https://drive.google.com/file/d/1e_RuzEVDg-FaIAuYo8OXsmcKBug1GtyI/view?usp=sharing)

