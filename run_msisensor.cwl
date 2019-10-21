class: Workflow
cwlVersion: v1.0
id: run_delly
label: run_delly 

inputs:
  bam_normal:
    type: File
    secondaryFiles:
      - ^.bai

  bam_tumor:
    type: File
    secondaryFiles:
      - ^.bai

  msisensor_list:
    type: File
 
outputs:
  output:
    run_msisensor/output
    type: File

steps:
  tumor_bam_indexed:
    in:
      bam: bam_tumor
    out: [ output ]
    run: ./cp_bai.cwl

  normal_bam_indexed:
    in:
      bam: bam_normal
    out: [ output ]
    run: ./cp_bai.cwl

  run_msisensor:
    in: 
      d: msisensor_list
      t: tumor_bam_indexed/output
      n: normal_bam_indexed/output
      o:
        valueFrom: ${ return inputs.t.basename.replace(".bam","") + "_" + inputs.t.basename.replace(".bam","") + ".msisensor.tsv"; }
    out: [ output ]
    run: command_line_tools/msisensor_0.5/msisensor.cwl

requirements:
  - class: SubworkflowFeatureRequirement
  - class: ScatterFeatureRequirement
  - class: InlineJavascriptRequirement
  - class: StepInputExpressionRequirement
