# NYCFlights13 Flight Delay Analysis

## Project Overview
Flight delays affect millions of passengers annually, leading to lost time and increased costs. This project analyzes flight delays from the `NYCFLIGHTS13` dataset, focusing on the relationships between weather conditions, departure delays, and arrival delays. The primary objective is to predict and understand factors contributing to flight delays using regression and classification models.

---

## Data
- **Source**: The `NYCFLIGHTS13` R package, which includes flights and weather data for New York airports in 2013. The nycflights13 dataset contains information on all domestic flights departing from three major New York City airports in the year 2013.
- **Datasets Used**:
  - **Flights**: 336,776 rows and 19 features (e.g., departure delay, arrival delay, flight origin).
  - **Weather**: Hourly meteorological data for New York airports.

The datasets were joined on common features like `year`, `month`, `day`, `hour`, and `origin`.

### Key Sources of the Data
#### Flight Data
- Collected from the **Bureau of Transportation Statistics (BTS)**.
- Includes details about flights such as departure and arrival times, delays, airlines, and flight numbers.

#### Weather Data
- Sourced from the **National Oceanic and Atmospheric Administration (NOAA)**.
- Provides hourly weather observations for the New York City airports.

#### Airports Data
- Includes metadata about airports (e.g., name, location) from the **Federal Aviation Administration (FAA)**.

#### Airlines Data
- Provides information about airlines (e.g., carrier codes and names).

---

## Objectives
1. Perform regression analysis to predict arrival delays based on:
   - Departure delay
   - Visibility
   - Wind gusts
   - Pressure
2. Use classification models (e.g., Random Forest) to predict whether flights are delayed or on time.

---

## Key Findings
1. **Regression Results**:
   - Departure delay is the most significant predictor of arrival delay ( R^2 = 0.834 ).
   - Weather features (pressure, visibility, wind gust) have weak correlations with arrival delay but this may be due to lack of information on cancelled flights.
2. **Random Forest Classification**:
   - Accuracy: 76.72%
   - Feature Importance:
     - **Departure delay**: Most impactful.
     - **Visibility**: Least impactful.
3. **Recommendations**:
   - Add a "Cancelled" feature to better analyze weather-related cancellations.
4. **Visualizations**: Key plots showing correlations and feature importance can be found in the `outputs/` folder.

---

## Repository Structure
- **`data/`**: Contains the cleaned dataset (`flights_weather.csv`).
- **`scripts/`**: Contains R scripts for data preprocessing and analysis.
- **`outputs/`**: Visualizations, model results, and performance metrics.
- **`README.md`**: Project overview and documentation.

---

## How to Run the Code
1. **Requirements**:
   - R and RStudio
   - R packages: `NYCFLIGHTS13`, `dplyr`, `randomForest`

2. **Installation**:
   ```R
   install.packages(c("NYCFLIGHTS13", "dplyr", "randomForest"))
   ```

3. **Steps**:
   - Clone this repository:
     ```bash
     git clone https://github.com/yourusername/nycflights13_project.git
     ```
   - Open the scripts in RStudio.
   - Run `data_preprocessing.R` to clean and preprocess the data.
   - Run `analysis.R` to generate results and visualizations.

---

## Future Work
- Integrate airline-specific data for more granular insights.
- Explore seasonal and holiday-specific patterns.
- Test advanced machine learning models like Gradient Boosting or Neural Networks.

---

## Authors
- Joe El Hajj
- Sambir Sidhu, Carolina Angel

---

## Acknowledgments
Thanks to the developers of the `NYCFLIGHTS13` package and the R community for their valuable resources.

---

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Contact
For questions or collaboration, feel free to reach out to:
- Email: joeelhajj01@icloud.com
- LinkedIn: [joeelhajj](https://www.linkedin.com/in/joe-el-hajj-443518301/)
