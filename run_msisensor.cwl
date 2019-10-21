class: Workflow
cwlVersion: v1.0
id: run_delly
label: run_delly 

inputs:
  bam_normal:
    type: File

  bam_tumor:
    type: File

  msisensor_list:
    type: File
 
outputs:
  output:
    type: File
    outputSource: run_msisensor/output

steps:

  tumor_bam_sorted:
    in:
      input_bam: bam_tumor
      o:
        valueFrom: $(input_bam.basename.replace('.bam', '.msi_prestep1.bam'))
    out: [ bam_sorted ]
    run: command_line_tools/samtools_1.9/samtools_sort.cwl

  normal_bam_sorted:
    in:
      input_bam: bam_normal
      o:
        valueFrom: $(input_bam.basename.replace('.bam', '.msi_prestep1.bam'))
    out: [ bam_sorted ]
    run: command_line_tools/samtools_1.9/samtools_sort.cwl

  tumor_bam_indexed:
    in:
      input_bam: bam_tumor
    out: [ bam_index ]
    run: command_line_tools/samtools_1.9/samtools_index.cwl

  normal_bam_indexed:
    in:
      input_bam: bam_normal
    out: [ bam_index ]
    run: command_line_tools/samtools_1.9/samtools_index.cwl

  run_msisensor:
    in:
      d: msisensor_list
      t: bam_tumor
      t_i: tumor_bam_indexed/bam_index
      n: bam_normal
      n_i: normal_bam_indexed/bam_index
      o:
        valueFrom: ${ return inputs.t.basename.replace(".bam","") + "_" + inputs.t.basename.replace(".bam","") + ".msisensor.tsv"; }
    out: [ output ]
    run: command_line_tools/msisensor_0.5/msisensor.cwl

requirements:
  - class: SubworkflowFeatureRequirement
  - class: ScatterFeatureRequirement
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
