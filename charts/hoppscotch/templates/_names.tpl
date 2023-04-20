{{/*
Create web name and version as used by the chart label.
*/}}
{{- define "web.fullname" -}}
{{- printf "%s-%s" (include "hoppscotch.fullname" .) .Values.web.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create admin name and version as used by the chart label.
*/}}
{{- define "admin.fullname" -}}
{{- printf "%s-%s" (include "hoppscotch.fullname" .) .Values.admin.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create backend name and version as used by the chart label.
*/}}
{{- define "backend.fullname" -}}
{{- printf "%s-%s" (include "hoppscotch.fullname" .) .Values.backend.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
