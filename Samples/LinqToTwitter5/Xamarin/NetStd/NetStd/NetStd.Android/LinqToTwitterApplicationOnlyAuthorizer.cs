﻿using LinqToTwitter;
using NetStd.Droid;
using NetStd.Models;

[assembly: Xamarin.Forms.Dependency(typeof(LinqToTwitterApplicationOnlyAuthorizer))]
namespace NetStd.Droid
{
    public class LinqToTwitterApplicationOnlyAuthorizer : ILinqToTwitterAuthorizer
    {
        public IAuthorizer GetAuthorizer(string consumerKey, string consumerSecret)
        {
            return new ApplicationOnlyAuthorizer()
            {
                CredentialStore = new InMemoryCredentialStore
                {
                    ConsumerKey = consumerKey,
                    ConsumerSecret = consumerSecret,
                },
            };
        }
    }
}