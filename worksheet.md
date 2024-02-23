# Trimming Raw Reads Worksheet

<!--- Write name below --->
## Name: Baylee Christensen 

<!--- For this worksheet, answer the following questions--->

## Q1: What does "cleaning" your reads mean?
Answer: It means filtering out reads that do not meet the standards set through fastp,

### Q2: Open the script called "trim_raw_reads.sh". For every line that says ```insert description here```, replace that text with a description of what the line will do

### Q4: Attach an image of the plot from fastqc showing the average base quality from your reads files
![before-trimming-PHRED-plot-1](./raw_reads/SRR5138446_2_fastqc.html)
![before-trimming-PHRED-plot-1](./raw_reads/SRR5138446_2_fastqc.html)


---

## The following questions pertain to your first fastp run (without altering the parameters)
### Q5: How many reads were there in the R1 file before filtering?
Answer: 33967298
### Q6: How many bases were there in the R1 file before filtering?
Answer: 3430697098
### Q7: What proportion of bases were above PHRED score of 20 before filtering?
Answer: 3302100992(96.2516%)
### Q8: What proportion of bases were above PHRED score of 30 before filtering?
Answer: 3142189399(91.5904%) 

### Q13: How many reads were there in the R2 file before filtering?
Answer:33967298
### Q14: How many bases were there in the R2 file before filtering?
Answer:3430697098
### Q15: What proportion of bases were above PHRED score of 20 before filtering?
Answer: 3259178619(95.0005%)
### Q16: What proportion of bases were above PHRED score of 30 before filtering?
Answer: 3088361342(90.0214%)

### Q17: How many reads were there in the merged file after filtering?
Answer: 12295196
### Q18: How many bases were there in the merged file after filtering?
Answer: 1750796378
### Q19: What proportion of bases in the merged file were above PHRED score of 20 after filtering?
Answer: 1732019393(98.9275%)
### Q20: What proportion of bases in the merged file were above PHRED score of 30 after filtering?
Answer: 1670204489(95.3968%)

### Q21: What is the difference between the merged and unmerged files (in principle, not quantitatively)?
Answer: Merged is where the overlap sequences from read 1 and read 2 and combined into a single read. If there is no overlap the reads are put in unmerged.
### Q22: Why are the unmerged files for R1 and R2 different lengths?
Answer: The R1 had more cleaned reads and the other had more discarded reads.

---

## The following questions pertain to Remix 1 (the first time you change fastp parameters)
### Q23: What parameters did you change?
Answer: I changed the average read phred score -e from 25 to 30
### Q24: How did you expect this to change the filtering results (be specific)?
Answer: I would expect  the number of reads to decrease as the filtration criteria is more strict. There would be a higher percentage of bases that have the phred score over 30.
### Q25: Explain the results. Did the change cause an effect that matched your expectations? Use information from the fastp output to explain.
Answer: The filtration technique matched this expectation, as the number for qualifying bases and reads after filtering was less. It did also increase the percentage of bases above the phred score. 

---

## The following questions pertain to Remix 2 (the first time you change fastp parameters)
### Q26: What parameters did you change?
Answer: I changed -u the unqualified percent limit from -40 to -30
### Q27: How did you expect this to change the filtering results (be specific)?
Answer: I would expect the search criteria to be less stringent, giving me more data albeit the quality of the data may be a little lower.
Reads with more than 30% of bases below the quality score threshold will be discarded, compared to 40%.
### Q28: Explain the results. Did the change cause an effect that matched your expectations? Use information from the fastp output to explain.
Answer: What was different was my filtering results. Some information was unexpected. In my remix2, I had less reads passing the filter, more reads failed due to low quality, less reads failed due to  too many N, and less reads failed due to too short (this one makes sense to me). Essentially what I gather from this is that this worked on the short reads, but the other reads this effect caused more stringent measures to be placed on the reads themselves.  

