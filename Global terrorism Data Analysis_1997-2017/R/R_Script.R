# STAT8129 - Group 15 Assignment

# Most of the visualizations are interactive 
# Please install the libraries below if not their in the system
# Loading necessary libraries
library(tidyverse)
library(readxl)
library(ggplot2)
library(dplyr)
library(plotly)
library(janitor)
library(scales)
library(RColorBrewer)
library(forcats)

#loading dataset 
gtd <- read_excel("Global_Terrorism_Data.xlsx") %>% clean_names()

# Checking first 5 rows 
head(gtd)

# Clean column names
gtd <- janitor::clean_names(gtd)

# Adding total kills and no. of events
kills_by_year <- gtd %>%
  group_by(year) %>%
  summarise(total_kills = sum(number_of_kill, na.rm = TRUE),
    total_events = n(), .groups = "drop") %>%
  arrange(year)

# Shortlisting peak years and reasons for plotting
peak_years <- c(2001, 2007, 2014)
reasons <- c("2001"="9/11 attacks in the U.S.",
             "2007"="Insurgency in Iraq and Pakistan suicide bombings",
             "2014"="ISIS insurgency causing 41,000+ deaths")

# Adding reason against the year, in plot
peaks <- kills_by_year %>%
  filter(year %in% peak_years) %>%
  mutate(Reason = reasons[as.character(year)])

# Visualisation  1
# Line chart: Total kills vs total events per year
a <- ggplot(kills_by_year, aes(x = year)) +
  geom_line(aes(y = total_kills,  colour = "Total kills",  linetype = "Total kills"),  linewidth = 1) +
  geom_line(aes(y = total_events, colour = "Total events", linetype = "Total events"), linewidth = 1) +
  geom_smooth(aes(y = total_kills, colour = "Trend in deaths", linetype = "Trend in deaths"),
              method = "loess", se = TRUE, fill = "#fb9a99") +
  
  # Adding text and dots to the peak years noted above
  geom_point(data = peaks, aes(x = year, y = total_kills), size = 3, colour = "#1f78b4", inherit.aes = FALSE) +
  geom_text (data = peaks, aes(x = year, y = total_kills + 2000, label = Reason), size = 3.5, colour = "black", inherit.aes = FALSE) +
  
  # Adding a legend and labels to the graph
  scale_color_manual("Legend",   values = c("Total kills"="#1f78b4","Total events"="black","Trend in deaths"="#e31a1c")) +
  scale_linetype_manual("Legend",values = c("Total kills"="solid","Total events"="dashed","Trend in deaths"="solid")) +
  labs(title="Global Terrorism: Incidents vs Fatalities (1997–2017)",
       subtitle="Loess trend shown for deaths", x="Year", y="Count") +
  theme_minimal(base_size = 14) +
  theme(legend.position = "bottom",
        legend.title = element_text(size = 9, face = "bold"),
        legend.text  = element_text(size = 8))

# Making the graph interactive
ggplotly(a, tooltip = c("x","y","colour"), dynamicTicks = TRUE)

# Visualisation 2
# Lollipop Chart
# Count attacks by type and reorder
attack_counts <- gtd %>% count(attack_type, name="events") %>%
  arrange(desc(events)) %>% mutate(attack_type=fct_reorder(attack_type, events))

# Plotting chart, applying labels & making it interactive
b <- ggplot(attack_counts, aes(events, attack_type,
                               text=paste0("Attack Type: ", attack_type, "<br>Events: ", comma(events)))) +
  geom_segment(aes(x=0, xend=events, yend=attack_type), color="#1f78b4", linewidth=0.8) +
  geom_point(size=4, color="#1f78b4") +
  labs(title="Frequency of Attack Types (1997–2017)", x="Number of events", y=NULL) +
  scale_x_continuous(labels=comma) + theme_minimal(base_size=14) +
  theme(plot.title=element_text(face="bold"), panel.grid.major.y=element_blank())

ggplotly(b, tooltip="text")

# Visualisation 3 - Pie Chart
threshold <- 0.015  # threshold: group slices <1.5% into "Others"

# Aggregate target types -> club small ones -> sort
target_counts <- gtd %>%
  count(target_type, name="events") %>%
  mutate(group = if_else(events/sum(events) < threshold, "Others", target_type)) %>%
  group_by(group) %>%
  summarise(events = sum(events), .groups="drop") %>%
  arrange(desc(events))


# Plotting Chart
plot_ly(target_counts, type="sunburst",
        labels=~group, parents=rep("", nrow(target_counts)), values=~events,
        textinfo="label+percent entry",
        hovertemplate="<b>%{label}</b><br>Events: %{value:,}<br>Share: %{percentRoot:.1%}<extra></extra>") %>%
  layout(title="Target Types of Terrorist Attacks (1997–2017)")

# Visualisation 4 - Stacked Bar Chart
# Count events by target/attack, drop "Unknown", order targets by total
stacked_data <- gtd %>%
  filter(attack_type != "Unknown", target_type != "Other") %>%
  count(target_type, attack_type, name = "events") %>%
  group_by(target_type) %>% mutate(total = sum(events)) %>% ungroup() %>%
  arrange(desc(events))

# Annotate: totals for selected big targets
annot_targets <- c("Business","Government (General)","Military","Police","Private Citizens & Property")
annotations_df <- stacked_data %>% filter(target_type %in% annot_targets) %>%
  summarise(.by = target_type, total = sum(events)) %>%
  mutate(label = paste0("Total: ", comma(total)))

# plot: stacked bars + labels + nice tooltips
c <- ggplot(stacked_data, aes(target_type, events, fill = attack_type,
                              text = paste0("<b>Target:</b> ", target_type,
                                            "<br><b>Attack:</b> ", attack_type,
                                            "<br><b>Events:</b> ", comma(events)))) +
  geom_bar(stat = "identity") +
  geom_text(data = annotations_df, aes(target_type, total * 1.05, label = label),
            inherit.aes = FALSE, size = 3, fontface = "bold") +
  scale_y_continuous(labels = comma, expand = expansion(mult = c(0, .10))) +
  scale_fill_brewer(palette = "OrRd", name = "Attack type") +
  labs(title = "Frequency of attack types done on various targets (1997–2017)",
       subtitle = "Stacked incidents by attack type; ‘Unknown’ removed",
       x = "Target type", y = "Number of events") +
  theme_minimal(base_size = 14) +
  theme(legend.position = "bottom", axis.text.x = element_text(angle = 45, hjust = 1))

ggplotly(c, tooltip = "text")

# Visualisation 5 - Heatmap
# Summarise yearly severity per target (avg casualties/event)
sev <- gtd %>% group_by(year, target_type) %>%
  summarise(events=n(), killed=sum(number_of_kill,na.rm=TRUE), wounded=sum(number_of_wounded,na.rm=TRUE), .groups="drop") %>%
  mutate(severity=(killed+wounded)/pmax(events,1))

# Keep Top-10 targets by total events; cap severity at 95th pct for readability
top_targets <- sev %>% count(target_type, wt=events, name="total") %>% slice_max(total, n=10) %>% pull(target_type)
sev2 <- sev %>% filter(target_type %in% top_targets) %>% mutate(severity_cap=pmin(severity, quantile(severity, .95, na.rm=TRUE))) %>%
  mutate(target_type=fct_reorder(target_type, events, .fun=sum, .desc=TRUE))

# Plotting Heatmap + interactive tooltips
d <- ggplot(sev2, aes(x=factor(year), y=target_type,
                      fill=severity_cap,
                      text=paste0("<b>Year:</b> ",year,"<br><b>Target:</b> ",target_type,
                                  "<br><b>Events:</b> ",comma(events),
                                  "<br><b>Killed:</b> ",comma(killed),
                                  "<br><b>Wounded:</b> ",comma(wounded),
                                  "<br><b>Avg casualties/event:</b> ",round(severity,2)))) +
  geom_tile() +
  scale_fill_gradient(name="Avg casualties\nper event", low="white", high="#e31a1c", labels=label_number(accuracy=0.1)) +
  labs(title="Severity of Attacks by Target Type (Top 10, 1997–2017)",
       subtitle="Average casualties (killed + wounded) per event • Values capped at 95th percentile",
       x="Year", y="Target type") +
  theme_minimal(base_size=13) + theme(axis.text.x=element_text(angle=45, hjust=1))

ggplotly(d, tooltip="text")

# Visualisation 6 - Stacked Area Chart
# Top-10 groups by total events (drop "Unknown")
top_groups <- gtd %>% filter(gname != "Unknown") %>%
  count(gname, name = "total") %>%
  slice_max(total, n = 10) %>%
  arrange(desc(total)) %>% pull(gname)

# Yearly counts per group, complete missing years with 0
yrs <- seq(min(gtd$year, na.rm=TRUE), max(gtd$year, na.rm=TRUE))
group_activity <- gtd %>% filter(gname %in% top_groups) %>%
  count(year, gname, name = "events") %>%
  complete(year = yrs, gname = top_groups, fill = list(events = 0)) %>%
  mutate(Group = factor(gname, levels = top_groups),   # order by total events
         Year = year, Events = events) %>%
  select(Year, Group, Events)

# Stacked area: activity of top-10 terror groups (1997–2017)
plot_ly(group_activity, x=~Year, y=~Events, color=~Group, colors="Set3",
        type="scatter", mode="none", stackgroup="one",
        hovertemplate="<b>%{fullData.name}</b><br>Year: %{x}<br>Events: %{y:,}<extra></extra>") %>%
  layout(title="Activity of Top 10 Terrorist Groups (1997–2017)",
         xaxis=list(title="Year"),
         yaxis=list(title="Number of events", rangemode="tozero"),
         legend=list(orientation="v", x=1.05, y=0.5))

# visualisation 7 - Bar Plot
# Top-4 groups
top_groups <- gtd %>% filter(gname!="Unknown") %>%
  count(gname, sort=TRUE) %>% slice_head(n=4) %>% pull(gname)

# Prep: year × group × weapon, drop Unknowns
gw <- gtd %>%
  filter(gname %in% top_groups, weapon_type!="Unknown") %>%
  count(year, gname, weapon_type, name="events") %>%
  group_by(gname) %>% mutate(total_group=sum(events)) %>% ungroup() %>%
  mutate(Group=fct_reorder(gname, total_group, .desc=TRUE),
         Weapon=if_else(grepl("^Vehicle", weapon_type), "Vehicle", weapon_type),  # shorten label
         Year=year, Events=events)

# Stacked bar faceted by group, reversed palette so common weapons = darker
e <- ggplot(gw, aes(Year, Events, fill=Weapon,
                    text=paste0("<b>Group:</b> ", Group,
                                "<br><b>Year:</b> ", Year,
                                "<br><b>Weapon:</b> ", Weapon,
                                "<br><b>Events:</b> ", comma(Events)))) +
  geom_col() +
  facet_wrap(~Group, ncol=2, scales="free_y") +
  scale_fill_brewer(palette="OrRd", direction=-1, name="Weapon type") +  # reversed colors
  scale_y_continuous(labels=comma, expand=expansion(mult=c(0,.05))) +
  labs(title="Weapon Use Over Time by Top Terror Groups (1997–2017)",
       subtitle="Stacked incidents by weapon type (Unknown removed)",
       x="Year", y="Number of events") +
  theme_minimal(base_size=13) +
  theme(legend.position="bottom", axis.text.x=element_text(angle=45, hjust=1))

ggplotly(e, tooltip="text")

# Visualisation 8 - World Map
# incidents by country (fix names so plotly recognizes them)
country_counts <- gtd %>%
  mutate(country_map = dplyr::recode(country,
                                     "Russia"="Russian Federation",
                                     "United States"="United States of America",
                                     "Congo, Democratic Republic of the"="Democratic Republic of the Congo",
                                     "Congo"="Republic of the Congo",
                                     "Syria"="Syrian Arab Republic",
                                     "Venezuela"="Venezuela",
                                     "Laos"="Lao PDR",
                                     "Iran, Islamic Republic of"="Iran",
                                     "Tanzania, United Republic of"="Tanzania",
                                     "Macedonia"="North Macedonia",
                                     "Czech Republic"="Czechia",
                                     .default = country)) %>%
  count(country_map, name = "incidents")

# choropleth (country names mode) + clean hover + natural earth projection
plot_geo(country_counts) %>%
  add_trace(
    locations = ~country_map, locationmode = "country names",
    z = ~incidents, color = ~incidents, colors = "Reds",
    text = ~paste0("<b>", country_map, "</b><br>Incidents: ", comma(incidents)),
    hovertemplate = "%{text}<extra></extra>"
  ) %>%
  colorbar(title = "Incidents", tickformat = ",") %>%
  layout(
    title = list(text = sprintf("Terrorist Incidents by Country (1997-2017)")),
    geo = list(showframe = FALSE, showcoastlines = TRUE, coastlinecolor = "gray70",
               projection = list(type = "natural earth"))
  )
