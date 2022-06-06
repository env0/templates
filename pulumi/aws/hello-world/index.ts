import * as apigateway from "@pulumi/aws-apigateway";
import * as s3 from "@pulumi/aws/s3";
import * as fs from 'fs';

const indexTemplate = fs.readFileSync('index.template.html', 'utf-8');
const index = indexTemplate.replace(new RegExp('!!!USER!!!', 'g'), process.env.USER!);
fs.writeFileSync('www/index.html', index);

const api = new apigateway.RestAPI("api", {
    staticRoutesBucket: new s3.Bucket('hello-pulumi', { forceDestroy: true }),
    routes: [
      {
        path: "/",
        localPath: "www"
      },
    ],
  });

export const url = api.url;