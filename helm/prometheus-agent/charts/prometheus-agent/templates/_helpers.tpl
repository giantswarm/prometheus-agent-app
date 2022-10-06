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
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/version: {{ .Values.image.tag | default .Chart.AppVersion | quote }}
application.giantswarm.io/team: {{ index .Chart.Annotations "application.giantswarm.io/team" | quote }}
helm.sh/chart: {{ include "chart" . | quote }}
{{- end -}}

{{- define "psp.name" -}}
{{- include "name" . -}}-psp
{{- end -}}

{{- define "prometheus-agent.remote-write" -}}
{{- if or .Values.global.remoteWrite .Values.remoteWrite -}}
remoteWrite:
{{- range $remoteWrite := .Values.global.remoteWrite }}
- basicAuth:
    password:
      key: password
      name: {{ $remoteWrite.name }}-remote-write-api
    username:
      key: username
      name: {{ $remoteWrite.name }}-remote-write-api
  url: {{ $remoteWrite.url }}
{{- end -}}
{{- range $remoteWrite := .Values.remoteWrite }}
- basicAuth:
    password:
      key: password
      name: {{ $remoteWrite.name }}-remote-write-api
    username:
      key: username
      name: {{ $remoteWrite.name }}-remote-write-api
  url: {{ $remoteWrite.url }}
{{- end -}}
{{- else }}
remoteWrite: []
{{- end }}
{{- end -}}