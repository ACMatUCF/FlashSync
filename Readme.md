# FlashSync

The initial idea for CloudSync is to have a program that can portably sync a user's files on a flash drive across multiple cloud resources.

The purpose of this project is to teach students how to use the APIs for different services. The repository will contain both working and skeleton code.

## Possible services

* Dropbox
* Google Drive
* Microsoft SkyDrive

## Setup

First we'll cover downloading and installing the Dropbox SDK. 

We'll use the Python SDK. 

- Need to download the Python SDK
- Need to run installer script (may need to sudo)

## Authentication

First we'll cover Authentication using the Dropbox API

Dropbox authentication is compliant with the OAuth v1 specification. 

About OAuth:

OAuth provides a method for users to grant third-party access to their resources without sharing their passwords. It also provides a way to grant limited access (in scope, duration, etc.).

In the OAuth model, the client (which is not the resource owner, but is acting on its behalf) requests access to resources controlled by the resource owner, but hosted by the server.

In order for the client to access resources, it first has to obtain permission from the resource owner.  This permission is expressed in the form of a token and matching shared-secret.  The purpose of the token is to make it unnecessary for the resource owner to share its credentials with the client.  Unlike the resource owner credentials, tokens can be issued with a restricted scope and limited lifetime, and revoked independently.

OAuth uses three kinds of credentials: client credentials, temporary credentials, and token credentials. 

The client credentials are used to authenticate the client.

Token credentials are used in place of the resource owner’s username and password. Instead of having the resource owner share its credentials with the client, it authorizes the server to issue a special class of credentials to the client which represent the access grant given to the client by the resource owner. The client uses the token credentials to access the protected resource without having to know the resource owner’s password.

The OAuth authorization process also uses a set of temporary credentials which are used to identify the authorization request. 

The OAuth specification consists of two parts. The first part defines a redirection-based browser process for end-users to authorize client access to their resources. This is done by having the users authenticate directly with the server, instructing the server to provision tokens to the client for use with the authentication method.

Example OAuth workflow: http://hueniverse.com/oauth/guide/workflow/