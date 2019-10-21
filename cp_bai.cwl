#!/usr/bin/env cwl-runner
cwlVersion: v1.0

class: CommandLineTool
baseCommand: [ cp ]

requirements:
  DockerRequirement:
    dockerPull: vanallenlab/msisensor:0.5
  InlineJavascriptRequirement: {}
  ResourceRequirement:
    ramMin: 2000
    coresMin: 1

doc: |
  Workaround for msisensor - just symlinks the index files

arguments:
  - position: 0
    shellQuote: false
    prefix: ''
    valueFrom: $(inputs.bam.path.replace('.bam', '.bai'))
  - position: 1
    shellQuote: false
    prefix: ''
    valueFrom: $(inputs.bam.basename) + '.bai'

inputs:
  bam:
    type: File
    doc: bam file
    secondaryFiles: ["^.bai"]
    inputBinding:
      prefix: -i

outputs:
  output:
    type: File
    outputBinding:
      glob: *.*
    secondaryFiles:
      - ^.bai
      - bam.bai
