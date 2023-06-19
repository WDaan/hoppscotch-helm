{{/*
Expand the name of the chart.
*/}}
{{- define "hoppscotch.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "hoppscotch.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "hoppscotch.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "hoppscotch.labels" -}}
helm.sh/chart: {{ include "hoppscotch.chart" .context }}
{{ include "hoppscotch.selectorLabels" (dict "context" .context "component" .component "name" .name) }}
app.kubernetes.io/version: {{ .context.Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .context.Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "hoppscotch.selectorLabels" -}}
app.kubernetes.io/name: {{ include "hoppscotch.name" .context }}-{{ .name }}
app.kubernetes.io/instance: {{ .context.Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "hoppscotch.serviceAccountName" -}}
{{- if .Values.global.serviceAccount.create }}
{{- default (include "hoppscotch.fullname" .) .Values.global.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Renders a value that contains template.
Usage:
{{ include "common.tplvalues.render" ( dict "value" .Values.path.to.the.Value "context" $) }}
*/}}
{{- define "common.tplvalues.render" -}}
    {{- if typeIs "string" .value }}
        {{- tpl .value .context }}
    {{- else }}
        {{- tpl (.value | toYaml) .context }}
    {{- end }}
{{- end -}}

{{/*
Pod annotations 
*/}}
{{- define "common.classes.podAnnotations" -}}
  {{- if .Values.podAnnotations -}}
    {{- tpl (toYaml .Values.podAnnotations) . | nindent 0 -}}
  {{- end -}}
{{- end -}}

{{/* Return the target Kubernetes version */}}
{{- define "hoppscotch.tools.kubeVersion" -}}
{{- default .Capabilities.KubeVersion.Version .Values.kubeVersionOverride }}
{{- end }}

{{/* Return the appropriate apiVersion for autoscaling */}}
{{- define "hoppscotch.apiVersion.autoscaling" -}}
{{- if (.Values.apiVersionOverrides).autoscaling -}}
{{- print .Values.apiVersionOverrides.autoscaling -}}
{{- else if semverCompare "<1.23-0" (include "hoppscotch.tools.kubeVersion" .) -}}
{{- print "autoscaling/v2beta1" -}}
{{- else -}}
{{- print "autoscaling/v2" -}}
{{- end -}}
{{- end -}}

{{/* Format env vars */}}
{{- define "hoppscotch.env_vars" -}}
  {{- with . -}}
    {{- $result := list -}}
    {{- range $name, $value := . -}}
        {{- if or (kindIs "float64" $value) (kindIs "bool" $value) -}}
          {{- $result = append $result (dict "name" $name "value" ($value | toString)) -}}
        {{- else -}}
          {{- $result = append $result (dict "name" $name "value" $value) -}}
        {{- end -}}
      {{- end -}}
    {{- toYaml $result | nindent 0 -}}
  {{- end -}}
{{- end -}}
