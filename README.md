# Daily Bruin Wiki

This is the code used to host the Daily Bruin's wiki.

## Environment Variables

This wiki uses a couple of environment variables to allow authentication via
Google and secure sessions. For more information, read the wiki.js documentation
on [authentication](https://docs.requarks.io/wiki/install/authentication) and
[configuration](https://docs.requarks.io/wiki/install/configuration).

```
GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_SECRET=
SESSION_SECRET_KEY=
```

## SSH Key

This wiki also syncs all data to a
[private repository](https://github.com/daily-bruin/wiki-data) on GitHub. In
order to do this, wiki.js makes use of an SSH key. The public key is in the
repository and can be managed on GitHub
[here](https://github.com/daily-bruin/wiki-data/settings/keys).

## Code Modifications

All DB staffers have `@media.ucla.edu` emails. When they log in to the wiki for
the first time with this email, an account is automatically created for them. A
couple of changes in the codebase were required to make this work.

In `server/controllers/auth.js`:

```js
//Add `hd` property to get the '@media.ucla.edu' login
router.get(
  '/login/google',
  passport.authenticate('google', {
    scope: ['profile', 'email'],
    hd: 'media.ucla.edu',
  })
);
```

In `server/models/user.js`:

```js
profile.provider = _.lowerCase(profile.provider);
primaryEmail = _.toLower(primaryEmail);
if (_.split(primaryEmail, '@')[1] !== 'media.ucla.edu') {
  return Promise.reject(new Error(lang.t('auth:errors.invaliduseremail')));
}
```

default rights are also changed to `write`:

```js
rights: [
  {
    role: 'write',
    path: '/',
    exact: false,
    deny: false,
  },
],
```

Note also that the default login background photos have been changed and are in
`assets/images`.
