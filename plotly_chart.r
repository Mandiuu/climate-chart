# Load required libraries
library(plotly)
library(htmlwidgets)

# Create the dataset
disaster_data <- data.frame(
  DisasterType = c("Extreme Heat", "Air Pollution", "Flooding", "Earthquake",
                   "Cyclone", "Drought", "Food Scarcity", "Violence/War"),
  Count = c(32, 31, 30, 23, 18, 15, 13, 12)
)

# Set brown color for bars
bar_colors <- rep('rgba(121, 85, 72, 0.9)', nrow(disaster_data))  # soft brown

# Create interactive plot
fig <- plot_ly(
  data = disaster_data,
  x = ~Count,
  y = ~reorder(DisasterType, Count),
  type = 'bar',
  orientation = 'h',
  text = ~paste0("<b>", DisasterType, "</b><br>",
                 "Respondents: ", Count, " (", round(Count/sum(Count)*100, 1), "%)"),
  textposition = 'none',
  hoverinfo = 'text',
  hovertemplate = "%{text}<extra></extra>",
  marker = list(
    color = bar_colors,
    line = list(color = 'rgba(255,255,255,0.6)', width = 1.5),
    opacity = 0.9
  )
) %>%
  # Add value labels on bars
  add_text(
    x = ~Count + 0.5,
    y = ~reorder(DisasterType, Count),
    text = ~Count,
    textposition = "middle right",
    showlegend = FALSE,
    hoverinfo = 'skip',
    textfont = list(color = "black", size = 12, family = "Arial", weight = "bold")
  ) %>%
  layout(
    title = list(
      text = paste0(
        "<b>Climate disasters driving migration</b>",
        "<br><span style='font-size:13px; font-weight:normal;'>",
        "A DRUM survey of migrants in NYC found many, especially Bangladeshis,<br>",
        "left due to flooding, extreme heat, and cyclones.",
        "</span>"
      ),
      x = 0,
      y = 0.93,
      font = list(size = 18, family = "Arial")
    ),
    xaxis = list(
      title = list(
        text = "Number of Respondents",
        font = list(size = 11, family = "Arial")
      ),
      showgrid = TRUE,
      gridcolor = 'rgba(128,128,128,0.2)',
      gridwidth = 1,
      range = c(0, max(disaster_data$Count) * 1.15),
      fixedrange = TRUE,
      tickfont = list(size = 11, family = "Arial")
    ),
    yaxis = list(
      title = "",
      showgrid = FALSE,
      fixedrange = TRUE,
      tickfont = list(size = 11, family = "Arial")
    ),
    margin = list(t = 100, l = 120, r = 50, b = 100),  # more space below bars
    paper_bgcolor = 'white',
    plot_bgcolor = 'white',
    font = list(family = "Arial", size = 14)
  )

# Remove Plotly toolbar
fig <- config(
  fig,
  displayModeBar = FALSE,
  displaylogo = FALSE
)

# Set fixed width and height for WordPress embedding
fig$sizingPolicy <- htmlwidgets::sizingPolicy(
  browser.fill = FALSE,
  viewer.fill = FALSE,
  defaultWidth = 512,
  defaultHeight = 500
)

# Save as HTML
saveWidget(
  fig,
  "disaster_chart.html",
  selfcontained = TRUE,
  title = "Disaster Chart for Migration Reasons",
  libdir = "plotly_lib",
  background = "white"
)

# Display the chart
fig
