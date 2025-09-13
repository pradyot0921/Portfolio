# Global Terrorism Analysis (1997–2017)  
_Group 15 – STAT8129 Assignment_ 

## A study by:
- Hussain Parvez Jhanjharya - 48610666
- Niketh Girish Nair - 48632791
- Pradyot Jain - 48479985
- Tarun Babu Tadela -  48480304

## 📊 Project Overview  
This project analyzes terrorism trends worldwide between **1997 and 2017** using the **Global Terrorism Database (GTD)**.  
We explored four key questions:  
1. **Where** does terrorism happen?  
2. **When** does it peak or decline?  
3. **Who** is responsible for the attacks?  
4. **How severe** are the impacts on human lives?  

Our analysis combines **Power BI dashboards** and **R Markdown interactive visualizations** to deliver insights into incidents, fatalities, attack types, target types, terrorist groups, and operational success rates.  

---

## 📂 Dataset  
- **Source:** Kaggle – [Global Terrorism Database (GTD)](https://www.kaggle.com/datasets/START-UMD/gtd)  
- **Maintained by:** National Consortium for the Study of Terrorism and Responses to Terrorism (START), University of Maryland.  
- **Coverage:** 1970–2017 (we focused on 1997–2017 for this study).  

### Methodology Notes  
- The GTD records **each attack as one entry**, but if an attack involves **multiple locations, weapon types, or other variations**, it may be logged as **multiple rows**.  
- Our visualizations **preserve this methodology** to stay consistent with START’s standards.  

---

## 📑 Dataset & Column Description  

The dataset contains over **180,000 rows** and **130+ attributes**. Below is a summary of the **most relevant columns** we used:  

| Column Name            | Description |
|-------------------------|-------------|
| `eventid`              | Unique identifier for each incident. |
| `year` / `month` / `day` | Year, month, and day of the attack. |
| `country`              | Country where the attack took place. |
| `region`               | Geographic region of the attack. |
| `provstate`            | Province/state within the country. |
| `city`                 | City where the incident occurred. |
| `latitude` / `longitude` | Coordinates of the event (if available). |
| `attack_type`          | Primary method of attack (e.g., Bombing, Armed Assault, Hijacking). |
| `target_type`          | Type of target (e.g., Civilians, Military, Police, Government). |
| `targsubtype`          | Sub-category of the target (e.g., Private citizens, Business, Religious institution). |
| `gname`                | Name of the group claiming responsibility (e.g., Taliban, ISIS, Unknown). |
| `weapontype`           | Primary weapon type used (e.g., Explosives, Firearms, Incendiary, Vehicle). |
| `nkill` (`number_of_kill`) | Number of people killed. |
| `nwound` (`number_of_wounded`) | Number of people wounded. |
| `success`              | Binary variable (1 = attack succeeded, 0 = failed). |
| `suicide`              | Whether the attack was a suicide mission (1 = yes, 0 = no). |
| `extended`             | Whether the attack lasted more than 24 hours. |
| `property`             | Whether property damage occurred (1 = yes, 0 = no). |
| `claimed`              | Whether a group claimed responsibility. |
| `related`              | Links to other related incidents (if part of a series). |

> ⚠️ **Note**: Some values are coded numerically (e.g., regions, countries) and require mapping to descriptive labels using GTD’s codebook.  

---

## 📈 Analysis Highlights  
- **Trends:** Terrorism peaked in **2001 (9/11), 2007 (Iraq insurgency & Pakistan bombings), and 2014 (ISIS expansion)**.  
- **Geography:** South Asia and the Middle East/North Africa accounted for the majority of incidents and fatalities.  
- **Tactics:** Explosives dominate globally (>50% of attacks), followed by armed assaults (~25%).  
- **Targets:** Civilians face the most attacks and casualties, followed by military and police.  
- **Groups:** Taliban, ISIS, Boko Haram, and Al-Shabaab are the most active and lethal groups.  
- **Success Rate:** ~90% of terrorist operations succeed, though the rate declines slightly after 2015.  

---

## 📚 Supporting Sources  
To interpret peaks and declines, we referred to reputable sources such as:  
- **The Guardian**  
- **U.S. Department of State reports**  
- Academic and policy articles on terrorism and counter-terrorism  

---

## 🛠️ Tools Used  
- **Power BI** – Dashboards for interactive exploration  
- **R (R Markdown, ggplot2, plotly, dplyr, etc.)** – Data cleaning, processing, and interactive plots  

---

## 🔗 How to Explore Further  
- **R Markdown File:** Contains code to replicate and extend the interactive visualizations.  
- **Power BI File:** Offers dashboards with slicers and drill-downs for deeper analysis.  
- **Dataset:** `Global_Terrorism_Data.xlsx` included for reproducibility.  

---

## 📌 Credits  
- Dataset: **START – Global Terrorism Database (University of Maryland)**  
- Project: **STAT8129 – Group 15 Assignment**  

# --------------- THANK YOU ---------------
