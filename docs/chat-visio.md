# Calls in Twake Chat

`twake-chat-visio-side-service` gives Twake Chat its call tokens. Chat finds it in
the well-known of Synapse (`org.matrix.msc4143.rtc_foci`) and asks
`https://matrix-rtc.${BASE_DOMAIN}/sfu/get`. The service checks that the caller is
in the room, as a Synapse application service, and asks Meet for the LiveKit
token of the call.

- In Meet, create an application with the scopes `rooms:create` and
  `rooms:livekit_token`.
- In `.env`, set `TWAKE_CHAT_VISIO_AS_TOKEN` and `TWAKE_CHAT_VISIO_HS_TOKEN`
  (`openssl rand -hex 32`) and the three `TWAKE_CHAT_VISIO_MEET_*`: the id and
  secret of that application, and the email of the owner of the call rooms. Then
  start `chat_app`. Without the AS token, Synapse keeps its usual configuration
  and the service is not part of the stack; without the Meet settings,
  `docker compose` stops and names the missing one.
- The AS token lets the service act as any user of Synapse: keep it as secret as
  an admin token.
- The image is not published yet: until then, build it and set
  `TWAKE_CHAT_VISIO_IMAGE` to its tag.
- The Meet of `meet_app` is the upstream `lasuite/meet-backend`, which has no
  `livekit-token/` route: the service answers 502 until the Meet fork is deployed.
- Synapse reads the registrations at startup only, and chat-react reads the
  well-known at startup: after changing these settings on a running stack,
  restart both (`docker restart chat_app-synapse-1 twake-space-chat`).
- After removing the AS token, `docker compose down --remove-orphans` removes the
  service's container.
