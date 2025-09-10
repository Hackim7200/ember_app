import { type ClientSchema, a, defineData } from "@aws-amplify/backend";

// Define all models in a single schema - this is the recommended Gen 2 approach
const schema = a.schema({
  User: a
    .model({
      name: a.string(),
    })
    .authorization((allow) => [allow.owner()]),

  Todo: a
    .model({
      content: a.string().required(),
      isDone: a.boolean().required(),
      pomodoros: a.integer().default(1),
      date: a.datetime().required(),
    })
    .authorization((allow) => [allow.owner()]),

  Event: a
    .model({
      title: a.string().required(),
      icon: a.integer().required(),
      date: a.datetime().required(),
    })
    .authorization((allow) => [allow.owner()]),
});

export type Schema = ClientSchema<typeof schema>;

export const data = defineData({
  schema,
  authorizationModes: {
    defaultAuthorizationMode: "userPool",
  },
});
