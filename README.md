
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

![WhatsApp Image 2024-11-01 at 22 26 43](https://github.com/user-attachments/assets/7a16f41c-9d28-4f9a-a477-e3944afe6241)

![WhatsApp Image 2024-11-01 at 22 26 44](https://github.com/user-attachments/assets/5810edd7-9612-4ee5-a384-4e34a5263677)

![WhatsApp Image 2024-11-01 at 22 26 43 (1)](https://github.com/user-attachments/assets/98497749-f735-467b-b86f-e0e11a70d777)



![WhatsApp Image 2024-11-01 at 22 26 44 (1)](https://github.com/user-attachments/assets/cd61f5bd-658a-46ab-9ee3-3d40f166ce11)

