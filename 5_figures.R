
# ############################################################################################


#       Figures


# ############################################################################################
library(ggplot2)

cb_palette <- c("#E69F00","#56B4E9","#009E73","#D55E00")


### Main KM plot

# Mom
m <- survfit(Surv(age_end,fail_sa2)~momD4period2,data=ch)
survTable <- data.frame(exposed = rep(c("No","Pregnancy","Before pregnancy","After pregnancy"), each=33),
                        time = m$time,
                        nRisk = m$n.risk,
                        nEvent = m$n.event,
                        nCens = m$n.censor,
                        cumhaz = m$cumhaz,
                        lci = m$lower,
                        uci = m$upper)
stargazer(survTable, summary=F, type="text", out="NOT_TO_EXPORT_cumhaz_table.txt")


d1 <- with(m, data.frame(time,cumhaz, strata=rep(1:4, each=length(cumhaz)/4)))
d1[,"strata"] <- factor(d1[,"strata"])
levels(d1[,"strata"] ) <- c("Never exposed","Pregnancy","Before pregnancy","After pregnancy" )
d1$Exposure <- d1$strata
pl_mom <- ggplot(d1, aes(x=time, y=cumhaz, group=factor(Exposure), col=Exposure)) +
  # geom_point()+
  geom_smooth(linewidth=1, se=FALSE, method="gam", formula = y~s(x,bs="cs"))+
  scale_y_continuous("Cumulative hazard", limits = c(0,0.04)) +
  scale_x_continuous("Age", limits = c(10,42)) +
  scale_color_manual(values = cb_palette, name="Exposure period") +
  theme_bw(base_size = 14) +
  theme(legend.position = c(.8,.2)) +
  labs(title="A. Maternal infections"); pl_mom

ggsave("plots/plot_attempt_mom_smooth.png",
       width = 720*0.0264, height = 600*0.0264, units = "cm")


# Dad
m <- survfit(Surv(age_end,fail_sa2)~dadD4period2,data=ch)
survTable <- data.frame(exposed = c(rep("No",33),c(rep(c("Pregnancy","Before pregnancy","After pregnancy"), each=21))),
                        #survTable <- data.frame(exposed = crep(c("No","Pregnancy","Before pregnancy","After pregnancy"), each=21),
                        time = m$time,
                        nRisk = m$n.risk,
                        nEvent = m$n.event,
                        nCens = m$n.censor,
                        cumhaz = m$cumhaz,
                        lci = m$lower,
                        uci = m$upper)
survTable <- survTable[survTable$time<31,]
stargazer(survTable, summary=F, type="text", out="NOT_TO_EXPORT_cumhaz_table.txt")


#d1 <- with(m, data.frame(time,cumhaz, strata=c(rep(1,33),c(rep(c(2:4), each=21)))))
d1 <- with(m, data.frame(time=time[c(1:21,34:96)],cumhaz=cumhaz[c(1:21,34:96)], strata=rep(1:4, each=21)))
d1[,"strata"] <- factor(d1[,"strata"])
levels(d1[,"strata"] ) <- c("Never exposed","Pregnancy","Before pregnancy","After pregnancy" )
d1$Exposure <- d1$strata
pl_dad <- ggplot(d1, aes(x=time, y=cumhaz, group=factor(Exposure), col=Exposure)) +
  # geom_point()+
  geom_smooth(linewidth=1, se=FALSE, method="gam", formula = y~s(x,bs="cs"))+
  scale_y_continuous("Cumulative hazard", limits = c(0,0.04)) +
  scale_x_continuous("Age", limits = c(10,30)) +
  scale_color_manual(values = cb_palette, name="Exposure period") +
  theme_bw(base_size = 14) +
  theme(legend.position = c(.85,.2)) +
  labs(title="B. Paternal infections"); pl_dad

ggsave("plots/plot_attempt_dad_smooth.png",
       width = 720*0.0264, height = 600*0.0264, units = "cm")



# Trimesters
m <- survfit(Surv(age_end,fail_sa2)~D4trim,data=ch)
survTable <- data.frame(exposed = rep(c("No","Pregnancy","Before pregnancy","After pregnancy"), each=33),
                        time = m$time,
                        nRisk = m$n.risk,
                        nEvent = m$n.event,
                        nCens = m$n.censor,
                        cumhaz = m$cumhaz,
                        lci = m$lower,
                        uci = m$upper)
stargazer(survTable, summary=F, type="text", out="NOT_TO_EXPORT_cumhaz_table.txt")


d1 <- with(m, data.frame(time,cumhaz, strata=rep(1:4, each=length(cumhaz)/4)))
d1[,"strata"] <- factor(d1[,"strata"])
levels(d1[,"strata"] ) <- c("Not exposed","First trimester","Second trimester","Third trimester" )
d1$Exposure <- d1$strata
pl_trim <- ggplot(d1, aes(x=time, y=cumhaz, group=factor(Exposure), col=Exposure)) +
  # geom_point()+
  geom_smooth(linewidth=1, se=FALSE, method="gam", formula = y~s(x,bs="cs"))+
  scale_y_continuous("Cumulative hazard", limits = c(0,0.04)) +
  scale_x_continuous("Age", limits = c(10,30)) +
  scale_color_manual(values = cb_palette, name="Exposure period") +
  theme_bw(base_size = 14) +
  theme(legend.position = c(.8,.2)) ; pl_trim

ggsave("plots/plot_attempt_trimesters_smooth.png",
       width = 720*0.0264, height = 600*0.0264, units = "cm")




# Mortality
m <- survfit(Surv(age_end,sui22)~momD4period2,data=ch)
survTable <- data.frame(exposed = rep(c("No","Pregnancy","Before pregnancy","After pregnancy"), each=33),
                        time = m$time,
                        nRisk = m$n.risk,
                        nEvent = m$n.event,
                        nCens = m$n.censor,
                        cumhaz = m$cumhaz,
                        lci = m$lower,
                        uci = m$upper)
stargazer(survTable, summary=F, type="text", out="NOT_TO_EXPORT_cumhaz_table.txt")


d1 <- with(m, data.frame(time,cumhaz, strata=rep(1:4, each=length(cumhaz)/4)))
d1[,"strata"] <- factor(d1[,"strata"])
levels(d1[,"strata"] ) <- c("Not exposed","Pregnancy","Before pregnancy","After pregnancy" )
d1$Exposure <- d1$strata
pl_trim <- ggplot(d1, aes(x=time, y=cumhaz, group=factor(Exposure), col=Exposure)) +
  # geom_point()+
  geom_smooth(linewidth=1, se=FALSE, method="gam", formula = y~s(x,bs="cs"))+
  scale_y_continuous("Cumulative hazard", limits = c(0,0.01)) +
  scale_x_continuous("Age", limits = c(10,30)) +
  scale_color_manual(values = cb_palette, name="Exposure period") +
  theme_bw(base_size = 14) +
  theme(legend.position = c(.8,.2)) ; pl_trim

ggsave("plots/plot_mortality_smooth.png",
       width = 720*0.0264, height = 600*0.0264, units = "cm")



# Sex stratified

# one sex at the time - for the mom

m <- survfit(Surv(age_end,fail_sa2)~momD4period2,data=ch[ch$sex==1,])
survTable <- data.frame(exposed = rep(c("No","Pregnancy","Before pregnancy","After pregnancy"), each=33),
                        time = m$time,
                        nRisk = m$n.risk,
                        nEvent = m$n.event,
                        nCens = m$n.censor,
                        cumhaz = m$cumhaz,
                        lci = m$lower,
                        uci = m$upper)
stargazer(survTable, summary=F, type="text", out="NOT_TO_EXPORT_cumhaz_table.txt")

cb_palette <- c("#E69F00","#56B4E9","#009E73","#D55E00")

d1 <- with(m, data.frame(time,cumhaz, strata=rep(1:4, each=length(cumhaz)/4)))
d1[,"strata"] <- factor(d1[,"strata"])
levels(d1[,"strata"] ) <- c("Never exposed","Pregnancy","Before pregnancy","After pregnancy" )
d1$Exposure <- d1$strata
pl_mom_male <- ggplot(d1, aes(x=time, y=cumhaz, group=factor(Exposure), col=Exposure)) +
  # geom_point()+
  geom_smooth(linewidth=1, se=FALSE, method="gam", formula = y~s(x,bs="cs"))+
  scale_y_continuous("Cumulative hazard", limits = c(0,0.06)) +
  scale_x_continuous("Age", limits = c(10,42)) +
  scale_color_manual(values = cb_palette, name="Exposure period") +
  theme_bw(base_size = 14) +
  theme(legend.position = "none") +
  labs(title="A. Male"); pl_mom_male

ggsave("plots/plot_attempt_mom_male_smooth.png",
       width = 720*0.0264, height = 600*0.0264, units = "cm")



m <- survfit(Surv(age_end,fail_sa2)~momD4period2,data=ch[ch$sex==2,])
survTable <- data.frame(exposed = rep(c("No","Pregnancy","Before pregnancy","After pregnancy"), each=33),
                        time = m$time,
                        nRisk = m$n.risk,
                        nEvent = m$n.event,
                        nCens = m$n.censor,
                        cumhaz = m$cumhaz,
                        lci = m$lower,
                        uci = m$upper)
stargazer(survTable, summary=F, type="text", out="NOT_TO_EXPORT_cumhaz_table.txt")

cb_palette <- c("#E69F00","#56B4E9","#009E73","#D55E00")

d1 <- with(m, data.frame(time,cumhaz, strata=rep(1:4, each=length(cumhaz)/4)))
d1[,"strata"] <- factor(d1[,"strata"])
levels(d1[,"strata"] ) <- c("Never exposed","Pregnancy","Before pregnancy","After pregnancy" )
d1$Exposure <- d1$strata
pl_mom_female <- ggplot(d1, aes(x=time, y=cumhaz, group=factor(Exposure), col=Exposure)) +
  # geom_point()+
  geom_smooth(linewidth=1, se=FALSE, method="gam", formula = y~s(x,bs="cs"))+
  scale_y_continuous("Cumulative hazard", limits = c(0,0.06)) +
  scale_x_continuous("Age", limits = c(10,42)) +
  scale_color_manual(values = cb_palette, name="Exposure period") +
  theme_bw(base_size = 14) +
  theme(legend.position = c(.8,.2)) +
  labs(title="B. Feale"); pl_mom_female

ggsave("plots/plot_attempt_mom_female_smooth.png",
       width = 720*0.0264, height = 600*0.0264, units = "cm")







# one sex at the time -  for the dad

m <- survfit(Surv(age_end,fail_sa2)~dadD4period2,data=ch[ch$sex==1,])
survTable <- data.frame(exposed = rep(c("No","Pregnancy","Before pregnancy","After pregnancy"), each=33),
                        time = m$time,
                        nRisk = m$n.risk,
                        nEvent = m$n.event,
                        nCens = m$n.censor,
                        cumhaz = m$cumhaz,
                        lci = m$lower,
                        uci = m$upper)
stargazer(survTable, summary=F, type="text", out="NOT_TO_EXPORT_cumhaz_table.txt")

cb_palette <- c("#E69F00","#56B4E9","#009E73","#D55E00")

d1 <- with(m, data.frame(time,cumhaz, strata=rep(1:4, each=length(cumhaz)/4)))
d1[,"strata"] <- factor(d1[,"strata"])
levels(d1[,"strata"] ) <- c("Never exposed","Pregnancy","Before pregnancy","After pregnancy" )
d1$Exposure <- d1$strata
pl_mom_male <- ggplot(d1, aes(x=time, y=cumhaz, group=factor(Exposure), col=Exposure)) +
  # geom_point()+
  geom_smooth(linewidth=1, se=FALSE, method="gam", formula = y~s(x,bs="cs"))+
  scale_y_continuous("Cumulative hazard", limits = c(0,0.06)) +
  scale_x_continuous("Age", limits = c(10,42)) +
  scale_color_manual(values = cb_palette, name="Exposure period") +
  theme_bw(base_size = 14) +
  theme(legend.position = "none") +
  labs(title="A. Male"); pl_mom_male

ggsave("plots/plot_attempt_mom_male_smooth.png",
       width = 720*0.0264, height = 600*0.0264, units = "cm")



m <- survfit(Surv(age_end,fail_sa2)~momD4period2,data=ch[ch$sex==2,])
survTable <- data.frame(exposed = rep(c("No","Pregnancy","Before pregnancy","After pregnancy"), each=33),
                        time = m$time,
                        nRisk = m$n.risk,
                        nEvent = m$n.event,
                        nCens = m$n.censor,
                        cumhaz = m$cumhaz,
                        lci = m$lower,
                        uci = m$upper)
stargazer(survTable, summary=F, type="text", out="NOT_TO_EXPORT_cumhaz_table.txt")

cb_palette <- c("#E69F00","#56B4E9","#009E73","#D55E00")

d1 <- with(m, data.frame(time,cumhaz, strata=rep(1:4, each=length(cumhaz)/4)))
d1[,"strata"] <- factor(d1[,"strata"])
levels(d1[,"strata"] ) <- c("Never exposed","Pregnancy","Before pregnancy","After pregnancy" )
d1$Exposure <- d1$strata
pl_mom_female <- ggplot(d1, aes(x=time, y=cumhaz, group=factor(Exposure), col=Exposure)) +
  # geom_point()+
  geom_smooth(linewidth=1, se=FALSE, method="gam", formula = y~s(x,bs="cs"))+
  scale_y_continuous("Cumulative hazard", limits = c(0,0.06)) +
  scale_x_continuous("Age", limits = c(10,42)) +
  scale_color_manual(values = cb_palette, name="Exposure period") +
  theme_bw(base_size = 14) +
  theme(legend.position = c(.8,.2)) +
  labs(title="B. Feale"); pl_mom_female

ggsave("plots/plot_attempt_mom_female_smooth.png",
       width = 720*0.0264, height = 600*0.0264, units = "cm")




### IRR and IRD
library(ggplot2)
library(forcats)

dt <- read.csv("plotData.csv") # a csv file containing the estimates from the analyses in SAS
dt <- dt[dt$Infection!="",]
dt$Priod = factor(dt$Priod, levels=c("During","Before","After"))
dt$Priod <- fct_rev(dt$Priod)
dt$Infection <- factor(dt$Infection, levels=unique(dt$Infection))
dt$Infection <- fct_rev(dt$Infection)
dt$Analysis = factor(dt$Analysis, levels=unique(dt$Analysis))


plot1 <- ggplot(data=dt, aes(x=Infection, y=aIRR, ymin=aLCI, ymax=aUCI, col=Priod )) +
  facet_grid (Analysis~., drop=T,scales = "free_y", switch = "y", space = "free") +
  geom_hline(yintercept = 1, linetype = "dashed", color = "grey", size=0.8) +
  geom_pointrange(position = position_dodge2(width = .5)) +
  coord_flip() +
  theme_bw(base_size = 14) + 
  theme(legend.title=element_blank())+
  guides(color = guide_legend(reverse=TRUE)) +
  scale_color_manual(values=c("#0072B2", "#E69F00", "#009E73")) +
  ylab("Incidence Rate Ratio") +
  labs(title = "A.")
xlab(""); plot1



b12 = log(1.47)
b11 = log(2.22)
se12 = (log(1.68)-log(1.33))/(1.96*2)
se11 = (log(2.91)-log(1.40))/(1.96*2)

z_value = abs(b12 - b11) / sqrt( abs(se12^2 - se11^2) ); z_value
p_value = 2*pnorm(-abs(z_value)); round(p_value,3)



dt_during <- dt[dt$Priod=="During",c(1:4,8:11)]
dt_before <- dt[dt$Priod=="Before",c(2:4,8:11)]
dt_after <- dt[dt$Priod=="After",c(2:4,8:11)]

dtirr <- cbind(dt_during,dt_before,dt_after)
colnames(dtirr) <- c("Infection", 
                     "aIRR_d","aLCI_d","aUCI_d","sa_exposed_d","py_exposed_d","sa_nonexposed_d","py_nonexposed_d",
                     "aIRR_b","aLCI_b","aUCI_b","sa_exposed_b","py_exposed_b","sa_nonexposed_b","py_nonexposed_b",
                     "aIRR_a","aLCI_a","aUCI_a","sa_exposed_a","py_exposed_a","sa_nonexposed_a","py_nonexposed_a" )
dtirr


library(fmsb)

for (i in 1:nrow(dtirr)){
  rd <- ratedifference(a=dtirr$sa_exposed_d[i], b=dtirr$sa_exposed_b[i], dtirr$py_exposed_d[i], dtirr$py_exposed_b[i], CRC=FALSE, conf.level=0.95) 
  dtirr$ird_db[i] <- round(rd$estimate*100000,1)
  dtirr$lci_db[i] <- round(rd$conf.int*100000,2)[1]
  dtirr$uci_db[i] <- round(rd$conf.int*100000,2)[2]
  dtirr$pval_db[i] <- round(rd$p.value,3)
  
  rd <- ratedifference(a=dtirr$sa_exposed_d[i], b=dtirr$sa_exposed_a[i], dtirr$py_exposed_d[i], dtirr$py_exposed_a[i], CRC=FALSE, conf.level=0.95) 
  dtirr$ird_da[i] <- round(rd$estimate*100000,1)
  dtirr$lci_da[i] <- round(rd$conf.int*100000,2)[1]
  dtirr$uci_da[i] <- round(rd$conf.int*100000,2)[2]
  dtirr$pval_da[i] <- round(rd$p.value,3)
  
  rd <- ratedifference(a=dtirr$sa_exposed_b[i], b=dtirr$sa_exposed_a[i], dtirr$py_exposed_b[i], dtirr$py_exposed_a[i], CRC=FALSE, conf.level=0.95) 
  dtirr$ird_ba[i] <- round(rd$estimate*100000,1)
  dtirr$lci_ba[i] <- round(rd$conf.int*100000,2)[1]
  dtirr$uci_ba[i] <- round(rd$conf.int*100000,2)[2]
  dtirr$pval_ba[i] <- round(rd$p.value,3)
}

dtirr

dtirrplot <- data.frame(Infection = rep(dtirr$Infection,3),
                        ird = c(dtirr$ird_db,dtirr$ird_da,dtirr$ird_ba),
                        lci = c(dtirr$lci_db,dtirr$lci_da,dtirr$lci_ba),
                        uci = c(dtirr$uci_db,dtirr$uci_da,dtirr$uci_ba),
                        pval = c(dtirr$pval_db,dtirr$pval_da,dtirr$pval_ba),
                        comparison = rep(c("During vs Before", "During vs After", "Before vs After"), each=nrow(dtirr)),
                        Analysis = rep(dt$Analysis[1:10],3))

dtirrplot$comparison <- factor(dtirrplot$comparison, levels=c("Before vs After","During vs After","During vs Before"))
plot2 <- ggplot(data=dtirrplot, aes(x=Infection, y=ird, ymin=lci, ymax=uci, col=comparison )) +
  facet_grid (Analysis~., drop=T,scales = "free_y", switch = "y", space = "free") +
  geom_hline(yintercept = 0, linetype = "dashed", color = "grey", size=0.8) +
  geom_pointrange(position = position_dodge2(width = .5)) +
  coord_flip() +
  theme_bw(base_size = 14) + 
  scale_y_continuous(limits = c(-200,200)) +
  theme(legend.title=element_blank())+
  guides(color = guide_legend(reverse=TRUE)) +
  scale_color_manual(values=c("#0072B2", "#E69F00", "#009E73")) +
  ylab("Incidence Rate Difference\nper 100,000 person-year") +
  xlab("") +
  labs(title = "B."); plot2


library(patchwork)
plot1 | plot2




# Load required libraries
library(ggplot2)
library(dplyr)

# Create data frame
df <- data.frame(
  Trimester = rep(c("First", "Second", "Third"), times = 2),
  IRR = c(1.34, 1.55, 1.49, 1.15, 1.37, 1.41),
  LCI = c(1.14, 1.38, 1.36, 0.98, 1.22, 1.29),
  UCI = c(1.58, 1.75, 1.63, 1.35, 1.55, 1.54),
  Type = rep(c("Unadjusted", "Adjusted"), each = 3)
)

# Ensure Unadjusted comes first
df$Type <- factor(df$Type, levels = c("Unadjusted", "Adjusted"))

# Colorblind-friendly palette
cb_palette <- c("Unadjusted" = "#E69F00", "Adjusted" = "#0072B2" )

# Create plot
ggplot(df, aes(x = Trimester, y = IRR, color = Type)) +
  geom_hline(yintercept = 1, linetype = "dashed", color = "gray50") +
  geom_point(position = position_dodge(width = 0.5), size = 4) +
  geom_errorbar(aes(ymin = LCI, ymax = UCI), width = 0.2, position = position_dodge(width = 0.5), size=1.2) +
  scale_color_manual(values = cb_palette) +
  labs(
    y = "Incidence Rate Ratio (IRR)",
    x = "Trimester",
    color = "",
  ) +
  theme_bw(base_size = 16) +
  theme(
    legend.position = c(.8,.2)
  )


### Other plots



# Trimesters

# Load required libraries
library(ggplot2)
library(dplyr)

# Create data frame
df <- data.frame(
  Trimester = rep(c("First", "Second", "Third"), times = 2),
  IRR = c(1.34, 1.55, 1.49, 1.15, 1.37, 1.41),
  LCI = c(1.14, 1.38, 1.36, 0.98, 1.22, 1.29),
  UCI = c(1.58, 1.75, 1.63, 1.35, 1.55, 1.54),
  Type = rep(c("Unadjusted", "Adjusted"), each = 3)
)

# Ensure Unadjusted comes first
df$Type <- factor(df$Type, levels = c("Unadjusted", "Adjusted"))

# Colorblind-friendly palette
cb_palette <- c("Unadjusted" = "#E69F00", "Adjusted" = "#0072B2" )

# Create plot
ggplot(df, aes(x = Trimester, y = IRR, color = Type)) +
  geom_hline(yintercept = 1, linetype = "dashed", color = "gray50") +
  geom_point(position = position_dodge(width = 0.5), size = 4) +
  geom_errorbar(aes(ymin = LCI, ymax = UCI), width = 0.2, position = position_dodge(width = 0.5), size=1.2) +
  scale_color_manual(values = cb_palette) +
  labs(
    y = "Incidence Rate Ratio (IRR)",
    x = "Trimester",
    color = "",
  ) +
  theme_bw(base_size = 16) +
  theme(
    legend.position = c(.8,.2)
  )



### Suicide mortality

# Create data frame
df <- data.frame(
  Trimester = rep(c("During pregnancy", "Before pregnancy", "After pregnancy"), times = 2),
  IRR = c(1.02, 1.17, 0.98, 1.40, 2.07, 1.55),
  LCI = c(0.67, 0.72, 0.62, 0.92, 1.28, 0.97),
  UCI = c(1.56, 1.88, 1.56, 2.13, 3.35, 2.47),
  Type = rep(c("Unadjusted", "Adjusted"), each = 3)
)

# Ensure Unadjusted comes first
df$Type <- factor(df$Type, levels = c("Unadjusted", "Adjusted"))

# Colorblind-friendly palette
cb_palette <- c("Unadjusted" = "#E69F00", "Adjusted" = "#0072B2" )

# Create plot
ggplot(df, aes(x = Trimester, y = IRR, color = Type)) +
  geom_hline(yintercept = 1, linetype = "dashed", color = "gray50") +
  geom_point(position = position_dodge(width = 0.5), size = 4) +
  geom_errorbar(aes(ymin = LCI, ymax = UCI), width = 0.2, position = position_dodge(width = 0.5), size=1.2) +
  scale_color_manual(values = cb_palette) +
  labs(
    y = "Incidence Rate Ratio (IRR)",
    x = "Period of exposure",
    color = "",
  ) +
  theme_bw(base_size = 16) +
  theme(
    legend.position = c(.8,.8)
  )





### Heatmap
library(pheatmap)
library(viridis)

ch$suicide_attempt <- as.numeric(ch$fail_sa2)
ch$mat_infection_during_pregn <- as.numeric(ifelse(ch$momD4period2==1,1,0))
ch$mat_infection_before_pregn <- as.numeric(ifelse(ch$momD4period2==2,1,0))
ch$mat_infection_after_pregn <- as.numeric(ifelse(ch$momD4period2==3,1,0))
ch$pat_infection_during_pregn <- as.numeric(ifelse(ch$momD4period2==1,1,0))
ch$pat_infection_before_pregn <- as.numeric(ifelse(ch$momD4period2==2,1,0))
ch$pat_infection_after_pregn <- as.numeric(ifelse(ch$momD4period2==3,1,0))
ch$period_cat <- as.numeric(ch$newperiod2)
ch$low_birth_weight <- factor(ch$lbw)
levels(ch$low_birth_weight) <- c(1,0,NA)
ch$low_birth_weight <- as.numeric(as.character(ch$low_birth_weight))
ch$prematurity <- factor(ch$prematurity)
levels(ch$prematurity) <- c(1,0,NA)
ch$prematurity <- as.numeric(as.character(ch$prematurity))
ch$age_group <- as.numeric(ifelse(ch$newagegp2==1,0,1))
ch$mat_autoimmune <- as.numeric(ch$momD5)
ch$parental_psych_diag <- as.numeric(ch$any_parent_psyk)
ch$mat_psychotropic <- as.numeric(ch$mom_psych_med)
ch$individual_sex <- as.numeric(ch$sex - 1)

cor_data <- ch[,c("suicide_attempt","suicide",
                  "mat_infection_during_pregn","mat_infection_before_pregn","mat_infection_after_pregn",
                  "pat_infection_during_pregn","pat_infection_before_pregn","pat_infection_after_pregn",
                  "sex","age_group","low_birth_weight","prematurity",
                  "mom_age_birth","dad_age_birth","mom_alone","low_parental_income","mat_autoimmune",
                  "parental_psych_diag","mat_psychotropic")]

map <- cor(na.omit(cor_data))
map
pheatmap(map,
         cluster_rows = F, cluster_cols = F,
         display_numbers = T)

heatmap(map)
