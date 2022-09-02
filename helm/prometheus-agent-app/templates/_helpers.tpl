{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "labels.selector" -}}
app.kubernetes.io/name: {{ include "name" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "labels.common" -}}
{{ include "labels.selector" . }}
app.giantswarm.io/branch: {{ .Chart.Annotations.branch | replace "#" "-" | replace "/" "-" | replace "." "-" | trunc 63 | trimSuffix "-" | quote }}
application.giantswarm.io/commit: {{ .Chart.Annotations.commit | quote }}
application.kubernetes.io/managed-by: {{ .Release.Service | quote }}
application.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
application.giantswarm.io/team: {{ index .Chart.Annotations "application.giantswarm.io/team" | quote }}
giantswarm.io/managed-by: {{ .Release.Name | quote }}
helm.sh/chart: {{ include "chart" . | quote }}
{{- end -}}

{{/*
prometheus-image
*/}}
{{- define "prometheus-image" -}}
{{- if .Values.image.tag -}}
{{- printf "%s/%s:%s" .Values.image.registry .Values.image.name .Values.image.tag -}}
{{- else -}}
{{- printf "%s/%s:%s" .Values.image.registry .Values.image.name .Chart.AppVersion -}}
{{- end -}}
{{- end -}}


{{/*
external-url
*/}}
{{- define "external-url" -}}
{{- printf "http://%s.%s:9090" .Release.Name .Release.Namespace | trunc 63 | trimSuffix "-" -}}
{{- end -}}
