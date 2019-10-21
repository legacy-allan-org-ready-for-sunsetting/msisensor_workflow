class: CommandLineTool
cwlVersion: v1.0

baseCommand:
  - samtools
  - index
inputs:
  - id: input_bam
    type: 'File'
    inputBinding:
      position: 2
      prefix: '-b'
    doc: Input bam
outputs:
  - id: bam_index
    type: File
    outputBinding:
      glob: '*.bai'
requirements:
  - class: ResourceRequirement
    ramMin: 32000
    coresMin: 4
  - class: DockerRequirement
    dockerPull: 'mjblow/samtools-1.9:latest'
  - class: InlineJavascriptRequirement
'dct:contributor':
  'foaf:mbox': 'mailto:bolipatc@mskcc.org'
  'foaf:name': C. Allan Bolipata
'dct:creator':
  'foaf:mbox': 'mailto:bolipatc@mskcc.org'
  'foaf:name': C. Allan Bolipata
