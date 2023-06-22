create table "public"."contacts" (
    "wa_id" numeric not null,
    "profile_name" character varying,
    "created_at" timestamp with time zone default now(),
    "last_message_at" timestamp with time zone default now()
);


alter table "public"."contacts" enable row level security;

create table "public"."messages" (
    "id" bigint generated by default as identity not null,
    "chat_id" numeric not null,
    "message" jsonb not null,
    "created_at" timestamp with time zone not null default now(),
    "media_url" text,
    "wam_id" character varying not null
);


alter table "public"."messages" enable row level security;

create table "public"."webhook" (
    "id" bigint generated by default as identity not null,
    "created_at" timestamp with time zone default now(),
    "payload" jsonb
);


alter table "public"."webhook" enable row level security;

CREATE UNIQUE INDEX contacts_pkey ON public.contacts USING btree (wa_id);

CREATE UNIQUE INDEX messages_pkey ON public.messages USING btree (id);

CREATE UNIQUE INDEX messages_wam_id_key ON public.messages USING btree (wam_id);

CREATE UNIQUE INDEX webhook_pkey ON public.webhook USING btree (id);

alter table "public"."contacts" add constraint "contacts_pkey" PRIMARY KEY using index "contacts_pkey";

alter table "public"."messages" add constraint "messages_pkey" PRIMARY KEY using index "messages_pkey";

alter table "public"."webhook" add constraint "webhook_pkey" PRIMARY KEY using index "webhook_pkey";

alter table "public"."messages" add constraint "messages_wam_id_key" UNIQUE using index "messages_wam_id_key";

create policy "Enable select for authenticated users only"
on "public"."contacts"
as permissive
for select
to authenticated
using (true);


create policy "Enable select for authenticated users only"
on "public"."messages"
as permissive
for select
to authenticated
using (true);


