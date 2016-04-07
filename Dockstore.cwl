#!/usr/bin/env cwl-runner

class: CommandLineTool
id: "Seqware-BWA-Workflow"
label: "Seqware-BWA-Workflow"

description: |
    The BWA-Mem workflow from the ICGC PanCancer Analysis of Whole Genomes (PCAWG) project.
    For more information see the PCAWG project [page](https://dcc.icgc.org/pcawg) and our GitHub
    [page](https://github.com/ICGC-TCGA-PanCancer) for our code including the source for
    [this workflow](https://github.com/ICGC-TCGA-PanCancer/Seqware-BWA-Workflow).
    ```
    Usage:
    # fetch CWL
    $> dockstore cwl --entry quay.io/pancancer/pcawg-bwa-mem-workflow:2.6.8 > Dockstore.cwl
    # make a runtime JSON template and edit it
    $> dockstore convert cwl2json --cwl Dockstore.cwl > Dockstore.json
    # run it locally with the Dockstore CLI
    $> dockstore launch --entry quay.io/pancancer/pcawg-bwa-mem-workflow:2.6.8 \
        --json Dockstore.json
    ```

dct:creator:
  "@id": "http://orcid.org/0000-0002-7681-6415"
  foaf:name: "Brian O'Connor"
  foaf:mbox: "mailto:briandoconnor@gmail.com"

requirements:
  - class: ExpressionEngineRequirement
    id: "#node-engine"
    requirements:
    - class: DockerRequirement
      dockerPull: commonworkflowlanguage/nodejs-engine
    engineCommand: cwlNodeEngine.js
  - class: DockerRequirement
    dockerPull: quay.io/pancancer/pcawg-bwa-mem-workflow:2.6.8

inputs:
  - id: "#reads"
    type:
      type: array
      items: File
    inputBinding:
      position: 1
      prefix: "--file"

  - id: "#reference_gz"
    type: File
    description: 'the reference *.fa.gz file'
    inputBinding:
      position: 2
      prefix: "--reference-gz"

  - id: "#reference_gz_fai"
    type: File
    description: 'the reference *.fa.gz.fai file'
    inputBinding:
      position: 3
      prefix: "--reference-gz-fai"

  - id: "#reference_gz_amb"
    type: File
    description: 'the reference *.fa.gz.amb file'
    inputBinding:
      position: 4
      prefix: "--reference-gz-amb"

  - id: "#reference_gz_ann"
    type: File
    description: 'the reference *.fa.gz.ann file'
    inputBinding:
      position: 5
      prefix: "--reference-gz-ann"

  - id: "#reference_gz_bwt"
    type: File
    description: 'the reference *.fa.gz.bwt file'
    inputBinding:
      position: 6
      prefix: "--reference-gz-bwt"

  - id: "#reference_gz_pac"
    type: File
    description: 'the reference *.fa.gz.pac file'
    inputBinding:
      position: 7
      prefix: "--reference-gz-pac"

  - id: "#reference_gz_sa"
    type: File
    description: 'the reference *.fa.gz.sa file'
    inputBinding:
      position: 8
      prefix: "--reference-gz-sa"

outputs:
  - id: "#merged_output_bam"
    type: File
    outputBinding:
      glob: "merged_output.bam"
  - id: "#merged_output_bai"
    type: File
    outputBinding:
      glob: "merged_output.bam.bai"
  - id: "#merged_output_unmapped_bam"
    type: File
    outputBinding:
      glob: "merged_output.unmapped.bam"
  - id: "#merged_output_unmapped_bai"
    type: File
    outputBinding:
      glob: "merged_output.unmapped.bam.bai"

baseCommand: ["perl", "/home/seqware/Seqware-BWA-Workflow/run_seqware_workflow.pl"]
