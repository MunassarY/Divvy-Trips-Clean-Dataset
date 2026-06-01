# 🚴‍♂️ Cyclistic Bike-Share Analytics: Station Traffic & Rider Insights
An end-to-end data analytics project exploring bike-share performance, user segments (Members vs. Casual riders), ride preferences, and high-traffic stations using SQL data modeling and Power BI.

## 📌 Project Overview
This project uncovers actionable behavioral trends within the Cyclistic bike-share program using divvy trips. The core goal is to understand how Annual Members and Casual riders interact with the service, map operational bottlenecks across major stations, and highlight temporal usage spikes to support strategic marketing and resource allocation decisions.

## 🛠️ Tech Stack & Skills Demonstrated
- SQL (PostgreSQL): Common Table Expressions (CTEs), multi-dimensional conditional aggregations (CASE WHEN), window functions (ROW_NUMBER()), and table unions.
- Power Query (M): Query referencing, data normalization, structural optimization, and data modeling.
- Power BI: Dynamic interactive dashboarding, custom KPI tracking, multi-criteria slicing, and comprehensive behavior analysis.

## 📈 Key Dashboard Highlights & Insights
Based on the final analytical model and the Power BI layout, several strategic trends were uncovered:
1. **Rider Demographic Split**: Casual riders constitute a massive volume of total usage (87K / ~70.7%), outperforming annual members (36K / ~29.3%). This highlights an immense opportunity to target conversion marketing campaigns at casual users.
2. **Seasonal Demand Shifts**: Total trips significantly escalate between May and October, reaching a dramatic peak in August. Conversely, the winter months see an operational low.
- Average ride duration spikes early in the spring (April), signaling longer recreational trips as the weather warms up.

3. **Station Hotspots (Operational Load)**:

- Streeter Dr & Grand Ave and Navy Pier emerge as the highest-density stations by a massive margin, predominantly dominated by Classic Casual riders.
- Stations like Kingsbury St & Kinzie St display a starkly flipped demographic, serving almost exclusively Members, signifying a commuter-heavy hub.

4. **Hardware Preference Matrix**: Classic Bikes are heavily favored over electric bikes for both user types across high-volume stations.

## 💾 Step-by-Step Data Transformation Pipeline (SQL)
To construct a highly performant and balanced dashboard without rendering the BI application sluggish, the raw transactional trip data was aggregated and optimized using a highly structured SQL script (available in the project files).

**The pipeline was built using the following structural phases:**
- **Phase 1**: Inbound & Outbound Traffic Isolation Separate queries were constructed to handle start_station_name (Inbound) and end_station_name (Outbound) separately. This ensures that a single station's complete traffic foot traffic footprint is completely captured.

- **Phase 2**: Chronological and Temporal Partitioning
Extracted the month components from timestamps to group data chronologically, allowing the analysis of seasonal shifts.

- **Phase 3**: Multi-Dimensional Aggregation (CASE WHEN)
Flattened the transactional data rows into specific, high-value metrics. Calculated absolute total counts, average trip duration, and broke down usage simultaneously across user types (member vs. casual) and hardware configurations (classic_bike vs. electric_bike).

- **Phase 4**: Table Unioning
Combined the inbound and outbound traffic datasets into a unified dataset using a UNION ALL operation.

- **Phase 5**: Operational Peak Filtering via Window Functions
Applied the ROW_NUMBER() window function, partitioned by month and traffic type, and ordered by total trips descending. This dynamically ranked the stations and isolated the number one peak traffic hotspot (WHERE rank = 1) for every single month to prevent dashboard visual overcrowding.

## 📊 Step-by-Step Dashboard Architecture (Power BI)

1. **Data Connection & Power Query Optimization**
- Connected Power BI to the optimized SQL server database engine view file.
- To resolve dimension slicing issues without altering the original database records, the core dataset query was Referenced to create a secondary decoupled summary table (User_Totals_Summary).
- Normalized user attributes by selecting the metric categories and applying an Unpivot Columns transformation, switching the shape from wide column distributions into an optimized 2-row attribute layout suitable for slicing.

2. **UI Layout & Visual Development**
- ***KPI Summary Cards***: Placed core high-level metric indicators (Total Trips, Members Count, and Casuals Count) directly in the center-left pane for quick glance clarity.
- ***Time-Series Analysis***: Built a dual-axis line chart tracking Avg_duration_minutes against volume counts (electric_trips and classic_trips) over a 12-month timeline to map seasonal behaviors.
- ***Rider Segmentation***: Implemented a clean, proportional donut chart visualizing the total breakdown of Rider Type across all sub-categories.

- ***Station & Monthly Performance Breakdown***: Developed dedicated stacked bar charts for Top Stations / Top Riders and line progressions for Top Monthly Rides using coordinated categorical legends.

3. Interactivity & Slicing
- Configured synchronized categorical dropdown slicers at the top of the interface for Month and Traffic Type (Start/End).
- Adjusted model relationship behaviors to allow cross-filtering, allowing a single slicer selection to instantly filter structural calculations across all visual frames simultaneously.

![Cyclistic Dashboard Demo](../Divvy%20Trips%20Clean%20Dataset/video.gif)


## 🚀 How to Use / Reproduce
- **Database Setup**: Run the provided SQL script file in your database environment containing the historic divvy_trips dataset to extract the optimized dataset view.
- **Power BI Extraction**: Open the Power BI project workspace file and connect it to your generated database output or dataset file.

- **Enjoy the Insights**: Use the dynamic monthly filters and traffic toggle options to deep-dive into localized bike-sharing habits.

#### 💡 Connect with me on LinkedIn to discuss Data Engineering, SQL Optimization, or Power BI architecture projects!